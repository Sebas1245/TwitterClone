//
//  ComposeViewController.h
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 29/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN



@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic,weak) id<ComposeViewControllerDelegate> delegate;
@property (nonatomic,weak) Tweet *originalTweet;

@end


NS_ASSUME_NONNULL_END
