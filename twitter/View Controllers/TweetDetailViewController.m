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


@interface TweetDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSLog(@"%@", self.tweet);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0) {
        // deque first detail cell
        FirstDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstDetailCell"];
        cell.detailName.text = self.tweet.user.name;
        cell.detailDate.text = self.tweet.dateString;
        cell.detailUsername.text = self.tweet.user.screenName;
        cell.detailTweetText.text = self.tweet.text;
        
        NSURL *url = [NSURL URLWithString:self.tweet.user.profilePicture];
        [cell.detailProfilePic setImageWithURL:url];
        return cell;
    
    }
    else if(indexPath.row == 1) {
        // deque second detail cell
        SecondDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondDetailCell"];
        cell.detailFavCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        cell.detailRTCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        return cell;
    }
    else {
        // deque third detail cell
        ThirdDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdDetailCell"];
        cell.tweet = self.tweet;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
