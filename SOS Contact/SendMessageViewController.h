//
//  SendMessageViewController.h
//  SOS Contact
//
//  Created by Paul Keller on 30/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface SendMessageViewController : UIViewController <MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)sendMessage:(id)sender;

@end
