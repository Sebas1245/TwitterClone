//
//  TweetCell.h
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 28/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *repliesButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetsButton;
@property (weak, nonatomic) IBOutlet UIButton *favsButton;
@property (nonatomic,weak) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
