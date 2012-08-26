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

@class DetailViewController;

@interface MasterViewController : UITableViewController <UITableViewDataSource>
{
    AppDelegate *sharedDelegate;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
