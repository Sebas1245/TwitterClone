//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "TweetDetailViewController.h"

@interface TimelineViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)  UIRefreshControl *refreshControl;
@property int currentNumTweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    // init refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self loadTweets];
    
    self.currentNumTweets = 20;
    
    // begin animation for refresh control
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];
    // place refresh control into table view
    [self.tableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)clickedLogout:(id)sender {
    [self handleLogout];
}

-(void)handleLogout {
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    cell.tweet = tweet;
    
    // This should be refactored to be inside TweetCell.m
    cell.screenName.text = tweet.user.name;
    cell.tweetText.text = tweet.text;
    cell.userName.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    cell.tweetDate.text = tweet.createdAtString;
    [cell.favsButton setTitle:[NSString stringWithFormat:@"%d",tweet.favoriteCount] forState:UIControlStateNormal];
    [cell.retweetsButton setTitle:[NSString stringWithFormat:@"%d", tweet.retweetCount] forState:UIControlStateNormal];

    
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    
    [cell.profilePicture setImageWithURL:url];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)didTweet:(Tweet *)tweet {
    NSLog(@"didTweet is firing!");
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row + 1 == [self.arrayOfTweets count]) {
        [self loadMoreData];
    }
}

-(void)loadMoreData{
    self.currentNumTweets += 20;
    NSLog(@"Firing loadMoreData method");
    [[APIManager shared] refreshHomeTimeline:@(self.currentNumTweets) completion:^(NSArray *tweets, NSError *error) {
            if(tweets) {
                NSLog(@"Refreshed home timeline");
                self.arrayOfTweets = [[NSMutableArray alloc] initWithArray:tweets];
                [self.tableView reloadData];
            }
            else {
                NSLog(@"Error refreshing timeline: %@", error.localizedDescription);
            }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier]  isEqualToString:@"DetailSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.arrayOfTweets[indexPath.row];
        
        TweetDetailViewController *tweetDetailVC = [segue destinationViewController];
        tweetDetailVC.tweet = tweet;
    }
    else if([[segue identifier] isEqualToString:@"ReplySegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:[[sender superview] superview]];
        composeController.originalTweet = self.arrayOfTweets[indexPath.row];
        composeController.delegate = self;
    }
    else {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
}

@end
