//
//  SendMessageViewController.h
//  SOS Contact
//
//  Created by Paul Keller on 30/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <CoreLocation/CoreLocation.h>
#import "SOSConfig.h"

@interface SendMessageViewController : UIViewController <MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate>
{
    BOOL updateLocation;
    CLLocationManager * locationManager;
}

@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSString * geoLocation;
@property (strong, nonatomic) NSString * textLocation;
- (IBAction)sendMessage:(id)sender;

@end
