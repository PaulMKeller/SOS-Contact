//
//  CountryOM.h
//  Emergency Contact
//
//  Created by Paul Keller on 07/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryOM : NSObject

@property (nonatomic, retain) NSNumber * emergencyContactID;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSNumber * police;
@property (nonatomic, retain) NSNumber * medical;
@property (nonatomic, retain) NSNumber * fire;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) UIImage * flag;

- (id)init;

@end
