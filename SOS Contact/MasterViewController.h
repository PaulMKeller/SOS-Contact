//
//  MasterViewController.h
//  SOS Contact
//
//  Created by Paul Keller on 24/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryOM.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <UITableViewDataSource, CLLocationManagerDelegate>
{
    AppDelegate *sharedDelegate;
    BOOL updateLocation;
    CLLocationManager * locationManager;
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITableView *countriesTableView;

- (void)setUpTableView;
- (void)scrollToCurrentLocation;

@end
