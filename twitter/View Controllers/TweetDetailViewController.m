//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 30/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "FirstDetailViewCell.h"
#import "SecondDetailViewCell.h"
#import "ThirdDetailViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "ComposeViewController.h"


@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *detailName;

@property (weak, nonatomic) IBOutlet UILabel *detailUsername;
@property (weak, nonatomic) IBOutlet UILabel *detailTweetText;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;
@property (weak, nonatomic) IBOutlet UILabel *detailRTCount;
@property (weak, nonatomic) IBOutlet UILabel *detailFavCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetBtn;
@property (weak, nonatomic) IBOutlet UIButton *favsBtn;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:self.tweet.user.profilePicture];
    [self.detailProfilePicture setImageWithURL:url];
    self.detailName.text = self.tweet.user.name;
    self.detailUsername.text = self.tweet.user.screenName;
    self.detailTweetText.text = self.tweet.text;
    self.detailDate.text = self.tweet.dateString;
    self.detailFavCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];;
    self.detailRTCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    [self refreshRtData];
    [self refreshFavData];
    
}

- (IBAction)handleRetweet:(id)sender {
    if(self.tweet.retweeted) {
        self.tweet.retweeted = false;
        self.tweet.retweetCount--;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *err) {
            if(err) {
                NSLog(@"Error unretweeting tweet: %@", err.localizedDescription);
            }
            else {
                NSLog(@"Successfully unrewteeeted the following Tweet: %@", tweet.text);
                [self refreshRtData];
            }
        }];
    }
    else {
        self.tweet.retweeted = true;
        self.tweet.retweetCount++;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *err) {
            if(err) {
                NSLog(@"Error retweeting tweet: %@", err.localizedDescription);
            }
            else {
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [self refreshRtData];
            }
        }];
 
    }
}
- (IBAction)handleFavorite:(id)sender {
    if(self.tweet.favorited) {
        self.tweet.favorited = false;
        self.tweet.favoriteCount--;
        NSLog(@"Decreased count");
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *err) {
            if(err) {
                NSLog(@"Error unfavoriting tweet: %@", err.localizedDescription);
            }
            else {
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                [self refreshFavData];
            }
        }];
    }
    else {
        self.tweet.favorited = true;
        self.tweet.favoriteCount++;
        NSLog(@"Updated count");
        // TODO: Update cell UI
        
        // Todo: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [self refreshFavData];
            }
        }];
    }
}

-(void)refreshFavData {
    [self.favsBtn setSelected:self.tweet.favorited];
}

-(void)refreshRtData {
    [self.retweetBtn setSelected:self.tweet.retweeted];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.originalTweet = self.tweet;
}


@end
