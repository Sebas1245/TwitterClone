//
//  FirstDetailViewCell.h
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 30/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *detailProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *detailName;
@property (weak, nonatomic) IBOutlet UILabel *detailUsername;
@property (weak, nonatomic) IBOutlet UILabel *detailTweetText;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;

@end

NS_ASSUME_NONNULL_END
