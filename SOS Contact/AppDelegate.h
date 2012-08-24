//
//  AppDelegate.h
//  SOS Contact
//
//  Created by Paul Keller on 24/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryOM.h"

#include <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray * countriesArray;

- (NSString *)copyDatabaseToDocuments;
- (void) readCountryDetailsFromDatabaseWithPath:(NSString *)filePath;


@end
