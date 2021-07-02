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
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = CGColorCreateGenericRGB(47/255.0, 124/255.0, 246/255.0, 1);
    self.textView.delegate = self;
    self.tweetButton.enabled = false;
    if(self.originalTweet)
        self.textView.text = [NSString stringWithFormat:@"@%@", self.originalTweet.user.screenName];
    
}
- (IBAction)handleClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)handleTweet:(id)sender {
    if(!self.originalTweet) {
        [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet *newTweet, NSError *reqErr) {
            if(reqErr) {
                NSLog(@"Error sending tweet: %@", reqErr.localizedDescription);
                // do something else rather than just dismissing the view
            }
            else {
                [self.delegate didTweet:newTweet];
                NSLog(@"Successful tweet sent out!");
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }];
    }
    else {

        [[APIManager shared] postReply:self.textView.text : self.originalTweet.idStr completion:^(Tweet *reply, NSError *error) {
            if(error) {
                NSLog(@"Error sending reply: %@", error.localizedDescription);
                // do something else rather than just dismissing the view
            }
            else {
                [self.delegate didTweet:reply];
                NSLog(@"Successful reply sent out!");
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }];
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Set the max character limit
    int characterLimit = 140;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];
    NSLog(@"New text = %@", newText);
    if(newText.length == 0)
        self.tweetButton.enabled = false;
    else
        self.tweetButton.enabled = true;

    // TODO: Update character count label
    self.characterCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)newText.length];

    // Should the new text should be allowed? True/False
    return newText.length < characterLimit;
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
