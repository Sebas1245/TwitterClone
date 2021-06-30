//
//  SecondDetailViewCell.h
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 30/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailRTCount;
@property (weak, nonatomic) IBOutlet UILabel *detailFavCount;

@end

NS_ASSUME_NONNULL_END
