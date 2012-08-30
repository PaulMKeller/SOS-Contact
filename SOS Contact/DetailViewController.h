//
//  DetailViewController.h
//  SOS Contact
//
//  Created by Paul Keller on 24/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdditionalInformationViewController.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UIImageView *imageFlag;
@property (strong, nonatomic) IBOutlet UILabel *countryTitle;
@property (strong, nonatomic) IBOutlet UILabel *policeNumber;
@property (strong, nonatomic) IBOutlet UILabel *medicalNumber;
@property (strong, nonatomic) IBOutlet UILabel *fireNumber;
@property (strong, nonatomic) AdditionalInformationViewController *notesViewController;

- (IBAction)setNoteDetailItem:(id)sender;
- (IBAction)callPolice:(id)sender;
- (IBAction)callMedical:(id)sender;
- (IBAction)callFire:(id)sender;

@end
