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
@synthesize universalPickerView;
@synthesize sharedDelegate;
@synthesize pickerType;

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
    
    if (pickerType == K_BLOOD_TYPE_KEY) {
        yourBloodGroup.text = [NSString stringWithFormat:@"%@", [sharedDelegate.bloodTypesArray objectAtIndex:row]];
        //yourBloodGroup.tag = row;
    } else if (pickerType == K_NATIONALITY_KEY){
        yourNationality.text = [NSString stringWithFormat:@"%@", [sharedDelegate.nationalitiesArray objectAtIndex:row]];
        //yourNationality.tag = row;
    }
    
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










@end
