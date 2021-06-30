//
//  TweetCell.m
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 28/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"


@implementation TweetCell




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
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
- (IBAction)didTapRetweet:(id)sender {
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

-(void)refreshFavData {
    [self.favsButton setTitle:[NSString stringWithFormat:@"%d",self.tweet.favoriteCount] forState:UIControlStateNormal];
    [self.favsButton setSelected:self.tweet.favorited];
}

-(void)refreshRtData {
    [self.retweetsButton setTitle:[NSString stringWithFormat:@"%d",self.tweet.retweetCount] forState:UIControlStateNormal];
    [self.retweetsButton setSelected:self.tweet.retweeted];
}
@end
