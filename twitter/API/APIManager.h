//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSMutableArray *tweets, NSError *error))completion;
// POST tweet method
- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;
// POST favorite tweet method
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
// POST unfavorite method
- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
// POST retweet method
- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
// POST unretweet method
- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
// GET timeline with count for infinite scroll function
- (void)refreshHomeTimeline:(NSNumber *) numberOfTweets completion:(void(^)(NSArray *tweets, NSError *error))completion;
// POST reply method
- (void)postReply:(NSString *)text :(NSString *)id_existing_tweet completion:(void (^)(Tweet *, NSError *))completion;
@end
