//
//  ComposeViewController.m
//  twitter
//
//  Created by Sebastian Saldana Cardenas on 29/06/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
}
- (IBAction)handleClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)handleTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet *newTweet, NSError *reqErr) {
        if(reqErr) {
            NSLog(@"Error sending tweet: %@", reqErr.localizedDescription);
            // do something else rather than just dismissing the view
        }
        else {
            [self.delegate didTweet:newTweet];
            NSLog(@"Successful tweet sent out!");
            NSLog(@"%@",newTweet);
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
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
