//
//  YourDetailsViewController.h
//  SOS Contact
//
//  Created by Paul Keller on 28/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SOSConfig.h"

@interface YourDetailsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UILabel *yourDetailsSummary;
@property (strong, nonatomic) IBOutlet UILabel *yourNationality;
@property (strong, nonatomic) IBOutlet UILabel *yourBloodGroup;
@property (strong, nonatomic) IBOutlet UILabel *yourEmergencyContactSummary;
@property (strong, nonatomic) IBOutlet UIPickerView *universalPickerView;
@property (strong, nonatomic) AppDelegate * sharedDelegate;
@property (strong, nonatomic) NSString * pickerType;

- (IBAction)selectYourDetails:(id)sender;
- (IBAction)selectNationality:(id)sender;
- (IBAction)selectBloodGroup:(id)sender;
- (IBAction)selectEmergencyContact:(id)sender;

- (void)showPicker:(NSString *)title;

@end
