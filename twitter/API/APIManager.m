//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "Tweet.h"

static NSString * const baseURLString = @"https://api.twitter.com";

@interface APIManager()

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
         NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
         
         NSString *key= [dict objectForKey: @"consumer_Key"];
         NSString *secret = [dict objectForKey: @"consumer_Secret"];
    
    
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}

- (void)getHomeTimelineWithCompletion:(void(^)(NSMutableArray *tweets, NSError *error))completion {
    
    [self GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
       
        // Success
        NSMutableArray *tweets = [Tweet tweetsWithArray:tweetDictionaries];

        completion(tweets, nil);
       
        }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // There was en error
        completion(nil, error);
    }];
}

// POST tweet method
- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion {
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": text};
    
    [self POST:urlString parameters:parameters progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* _Nullable tweetDictionary) {
            Tweet *newTweet = [[Tweet alloc] initWithDictionary:tweetDictionary];
            completion(newTweet, nil); // callback to be handled and implemented when POST tweet method is called
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            completion(nil,error); // callback to be handled when there is an error with the POST request to the Twitter API
        }
    ];
}


@end
