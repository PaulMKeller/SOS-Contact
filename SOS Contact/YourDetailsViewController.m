//
//  YourDetailsViewController.m
//  SOS Contact
//
//  Created by Paul Keller on 28/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import "YourDetailsViewController.h"

@implementation YourDetailsViewController
@synthesize yourDetailsSummary;
@synthesize yourNationality;
@synthesize yourBloodGroup;
@synthesize yourEmergencyContactSummary;
@synthesize yourEmergencyContactNumber;
@synthesize universalPickerView;
@synthesize sharedDelegate;
@synthesize pickerType;
@synthesize yourContactRecord;
@synthesize yourEmergencyContactRecord;
@synthesize contactType;

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
    [super viewDidLoad];
    
    sharedDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    pickerType = K_NATIONALITY_KEY;
    
    universalPickerView.dataSource = self;
    universalPickerView.delegate = self;
    
    universalPickerView.hidden = YES;
    
    
    
}


- (void)viewDidUnload
{
    [self setYourDetailsSummary:nil];
    [self setYourNationality:nil];
    [self setYourBloodGroup:nil];
    [self setYourEmergencyContactSummary:nil];
    [self setUniversalPickerView:nil];
    [self setYourEmergencyContactNumber:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectYourDetails:(id)sender {
    contactType = K_YOUR_RECORD_KEY;
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)selectNationality:(id)sender {
    pickerType = K_NATIONALITY_KEY;
    //universalPickerView.hidden = NO;
    [universalPickerView reloadAllComponents];
    
    NSInteger rowSelected = [sharedDelegate.nationalitiesArray indexOfObject:yourNationality.text];
    
    if (rowSelected > sharedDelegate.nationalitiesArray.count) {
        rowSelected = 0;
    }
    
    [self showPicker:@"Pick Nationality"];
    
    [universalPickerView selectRow:rowSelected inComponent:0 animated:YES];
    
}

- (IBAction)selectBloodGroup:(id)sender {
    pickerType = K_BLOOD_TYPE_KEY;
    //universalPickerView.hidden = NO;
    [universalPickerView reloadAllComponents];
    
    NSInteger rowSelected = [sharedDelegate.bloodTypesArray indexOfObject:yourBloodGroup.text];
    
    if (rowSelected > sharedDelegate.bloodTypesArray.count) {
        rowSelected = 0;
    }
    
    [self showPicker:@"Pick Blood Type"];
    
    [universalPickerView selectRow:rowSelected inComponent:0 animated:YES];
    
    

}

- (IBAction)selectEmergencyContact:(id)sender {
    contactType = K_EMERGENCY_RECORD_KEY;
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}


#pragma PickerView Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView { // This method needs to be used. It asks how many columns will be used in the UIPickerView
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component { // This method also needs to be used. This asks how many rows the UIPickerView will have.
	// We will need the amount of rows that we used in the pickerViewArray, so we will return the count of the array.
    if (pickerType == K_BLOOD_TYPE_KEY) {
        return [sharedDelegate.bloodTypesArray count];
    } else if (pickerType == K_NATIONALITY_KEY){
        return [sharedDelegate.nationalitiesArray count];
    } else {
        return 0; //This shouldn't happen...
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // We will set a new row for every string used in the array.
    if (pickerType == K_BLOOD_TYPE_KEY) {
        return [sharedDelegate.bloodTypesArray objectAtIndex:row];
    } else if (pickerType == K_NATIONALITY_KEY){
        return [sharedDelegate.nationalitiesArray objectAtIndex:row];
    } else {
        return 0; //This shouldn't happen
    }
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component { // And now the final part of the UIPickerView, what happens when a row is selected.
    NSUserDefaults * defaults  = [NSUserDefaults standardUserDefaults];
    
    if (pickerType == K_BLOOD_TYPE_KEY) {
        yourBloodGroup.text = [NSString stringWithFormat:@"%@", [sharedDelegate.bloodTypesArray objectAtIndex:row]];
        //yourBloodGroup.tag = row;
        [defaults setObject:yourBloodGroup.text forKey:K_BLOOD_TYPE_KEY];
    } else if (pickerType == K_NATIONALITY_KEY){
        yourNationality.text = [NSString stringWithFormat:@"%@", [sharedDelegate.nationalitiesArray objectAtIndex:row]];
        //yourNationality.tag = row;
        [defaults setObject:yourNationality.text forKey:K_NATIONALITY_KEY];
    }
    [defaults synchronize];
    //universalPickerView.hidden = YES;
}

- (void)showPicker:(NSString *)title {    
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:title
                                                      delegate:self
                                             cancelButtonTitle:@"Done"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
    
    universalPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,180,0,0)];
    universalPickerView.delegate = self;
    universalPickerView.dataSource = self;
    universalPickerView.showsSelectionIndicator = YES;    
    [menu addSubview:universalPickerView];
    [menu showInView:self.view.superview];
    
    //Change the height value in your CGRect to change the size of the actinsheet
    [menu setBounds:CGRectMake(0,0,320, 615)];
    
}

#pragma AddressBook Methods
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)displayPerson:(ABRecordRef)person
{
    NSUserDefaults * defaults  = [NSUserDefaults standardUserDefaults];
    
    NSString* firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    if (contactType == K_YOUR_RECORD_KEY) {
        
        self.yourDetailsSummary.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        [defaults setObject:firstName forKey:K_YOU_FIRST_NAME];
        [defaults setObject:lastName forKey:K_YOU_LAST_NAME];
        
        //yourContactRecord = person;
    } 
    else 
    {
        NSString * number = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonPhoneProperty);
        self.yourEmergencyContactSummary.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        self.yourEmergencyContactNumber.text = number;
        
        [defaults setObject:firstName forKey:K_SOS_FIRST_NAME];
        [defaults setObject:lastName forKey:K_SOS_LAST_NAME];
        [defaults setObject:number forKey:K_SOS_NUMBER];
        
        //yourEmergencyContactRecord = person;
    }
    
    
    [defaults synchronize];
    
//    NSString* phone = nil;
//    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
//                                                     kABPersonPhoneProperty);
//    if (ABMultiValueGetCount(phoneNumbers) > 0) {
//        phone = (__bridge_transfer NSString*)
//        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
//    } else {
//        phone = @"[None]";
//    }
//    //self.phoneNumber.text = phone;
}







@end
