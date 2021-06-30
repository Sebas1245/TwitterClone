//
//  ThirdDetailViewCell.h
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 30/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThirdDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *detailRTBtn;
@property (weak, nonatomic) IBOutlet UIButton *detailFavBtn;

@property (nonatomic,weak) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
