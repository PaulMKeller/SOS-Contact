//
//  AppDelegate.m
//  SOS Contact
//
//  Created by Paul Keller on 24/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize countriesArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    countriesArray = [[NSMutableArray alloc] init];
    
    NSString * filePath = [self copyDatabaseToDocuments];
    
    [self readCountryDetailsFromDatabaseWithPath:filePath];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma DataBase Methods
- (NSString *)copyDatabaseToDocuments {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [paths objectAtIndex:0];
    NSString * filePath = [documentsPath stringByAppendingPathComponent:@"EmergencyContact.sqlite"]; //HAS TO BE THE FULL NAME OF THE FILE. EmergencyContact on it's own won't do.
    
    if (![fileManager fileExistsAtPath:filePath]) {
        NSString * bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"EmergencyContact.sqlite"];
        [fileManager copyItemAtPath:bundlePath toPath:filePath error:nil];
    }
    
    return filePath;
}

- (void) readCountryDetailsFromDatabaseWithPath:(NSString *)filePath
{
    sqlite3 * database;
    if (sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
        const char * sqlStatement = "SELECT ID, Country, Police, Medical, Fire, Notes, Region FROM Contact order by country";
        sqlite3_stmt * compiledStatement;
        if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSNumber * dbID = [NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, 0)];
                NSString * dbCountry =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSNumber * dbPolice = [NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, 2)];
                NSNumber * dbMedical = [NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, 3)];
                NSNumber * dbFire =  [NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, 4)];

                NSString * dbNotes;
                if (sqlite3_column_text(compiledStatement, 5) != nil) {
                    dbNotes = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                } 
                else
                {
                    dbNotes = @"";
                }
                
                NSString * dbRegion =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                
                CountryOM * currCountry = [[CountryOM alloc] init];
                
                currCountry.EmergencyContactID = dbID;
                currCountry.Country = dbCountry;
                currCountry.Region = dbRegion;
                currCountry.Police = dbPolice;
                currCountry.Medical = dbMedical;
                currCountry.Fire = dbFire;
                currCountry.Notes = dbNotes;
                
                currCountry.flag = [UIImage imageNamed:[NSString stringWithFormat:@"@%.png", dbCountry]];
                
//                NSLog(@"Country:%@, any spaces" , dbCountry);
//                NSLog(@"Police:%e" , dbPolice);
                
                [self.countriesArray addObject:currCountry];
            }
        } else
        {
            printf( "could not prepare statement: %s\n", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
}


@end
