//
//  SendMessageViewController.m
//  SOS Contact
//
//  Created by Paul Keller on 30/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import "SendMessageViewController.h"

@implementation SendMessageViewController

@synthesize locationManager;
@synthesize activityIndicator;
@synthesize geoLocation;
@synthesize textLocation;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [self setLocationManager:nil];
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
    
//    if (activityIndicator.isAnimating) {
//        [activityIndicator stopAnimating];
//    }
//    else
//    {
//        [activityIndicator startAnimating];
//    }
    
    [activityIndicator startAnimating];
     
//    [self composeMessage];
    [self performSelector: @selector(composeMessage) 
               withObject: nil 
               afterDelay: 0];
    
    
}

- (void)composeMessage
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        NSUserDefaults * defaults  = [NSUserDefaults standardUserDefaults];
        NSString * myName = [NSString stringWithFormat:@"%@ %@", [defaults objectForKey:K_YOU_FIRST_NAME], [defaults objectForKey:K_YOU_LAST_NAME]];
        NSString * myNationality = [defaults objectForKey:K_NATIONALITY_KEY];
        NSString * myBloodGroup = [defaults objectForKey:K_BLOOD_TYPE_KEY];
        
        NSString * nameString;
        if (myName != nil) {
            nameString = [NSString stringWithFormat:@" My name is %@. ", myName];
        } 
        else
        {
            nameString = @"";
        }
        
        NSString * nationalityString;
        if (myNationality != nil) {
            nationalityString = [NSString stringWithFormat:@" I am %@. ", myNationality]; 
        }
        else
        {
            nationalityString = @"";
        }
        
        NSString * bloodGroupString;
        if (myBloodGroup != nil) {
            bloodGroupString = [NSString stringWithFormat:@" My blood group is %@. ", myBloodGroup];
        }
        else
        {
            bloodGroupString = @"";
        }
        
        NSString * geoLocatioString;
        if (geoLocation != nil) {
            geoLocatioString = [NSString stringWithFormat:@" I'm here: %@. ", geoLocation];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location not found" message:@"Your location was not found. Try cancelling this message and trying again or manually enter your location." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            geoLocatioString = @" I'm here: <Location>. ";
        }
        
        NSString * messageBody = [NSString stringWithFormat:@"EMERGENCY SOS.%@%@%@%@. SEND HELP.", nameString, nationalityString, bloodGroupString, geoLocation];
        
        controller.body = messageBody;    
        //controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
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

#pragma Location Manager Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [manager stopUpdatingLocation];
    
    NSLog(@"Location: %@", [newLocation description]);
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
//            //NSLog(@"Placemark: %@", placemark);
//            //NSLog(@"Region: %@", [placemark region]);
//            geoLocation = [NSString stringWithFormat:@"%@", [placemark region]];
//            //NSLog(@"geoLocation: %@", geoLocation);
//            
//            NSDictionary *placemarkDictionary = [placemark addressDictionary];
//            NSString * placemarkAddress = [[placemarkDictionary objectForKey:@"FormattedAddressLines"] description];
//            //NSLog(@"placemarkAddress: %@", placemarkAddress);
//            
//            //Let's tidy up the address
//            placemarkAddress = [placemarkAddress stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            placemarkAddress = [placemarkAddress stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//            placemarkAddress = [placemarkAddress stringByReplacingOccurrencesOfString:@"(" withString:@""];
//            placemarkAddress = [placemarkAddress stringByReplacingOccurrencesOfString:@")" withString:@""];
//            placemarkAddress = [placemarkAddress stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//            placemarkAddress = [placemarkAddress stringByReplacingOccurrencesOfString:@"  " withString:@""];
//            
//            textLocation = [NSString stringWithFormat:@"%@", placemarkAddress];
//            
//            //NSLog(@"TextLocation: %@", textLocation);
            geoLocation = [NSString stringWithFormat:@"%@", placemark];
        }    
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error description]);
}
        
@end
