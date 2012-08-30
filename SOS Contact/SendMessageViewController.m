//
//  SendMessageViewController.m
//  SOS Contact
//
//  Created by Paul Keller on 30/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import "SendMessageViewController.h"

@implementation SendMessageViewController
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sendMessage:(id)sender {
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        NSString * messageBody = [NSString stringWithFormat:@"EMERGENCY SOS. This is not a spam message. I'm in trouble and I need help. Here is my location: @%.", @"XYZ"];
        
        
        controller.body = messageBody;    
        //controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    } 
    activityIndicator.hidden = YES;
    [activityIndicator stopAnimating];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
    {
        NSLog(@"Message cancelled");
    } else if (result == MessageComposeResultSent)
    {
        NSLog(@"Message sent") ; 
    } else
    {
        NSLog(@"Message failed");  
    }

}
        
@end
