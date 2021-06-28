//
//  Tweet.h
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 28/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

// PROPERTIES
@property (nonatomic, strong) NSString *idStr; // For favoriting, retweeting & replying
@property (nonatomic, strong) NSString *text; // Text content of tweet
@property (nonatomic) int favoriteCount; // Update favorite count label
@property (nonatomic) BOOL favorited; // Configure favorite button
@property (nonatomic) int retweetCount; // Update favorite count label
@property (nonatomic) BOOL retweeted; // Configure retweet button
@property (nonatomic, strong) User *user; // Contains Tweet author's name, screenname, etc.
@property (nonatomic, strong) NSString *createdAtString; // Display date

// For Retweets
@property (nonatomic, strong) User *retweetedByUser;  // user who retweeted if tweet is retweet

// Create initialzer
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

// method to return array of tweets instead of dictionary of tweets
+(NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
