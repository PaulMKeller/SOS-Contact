//
//  DetailViewController.m
//  SOS Contact
//
//  Created by Paul Keller on 24/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import "DetailViewController.h"
#import "CountryOM.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize imageFlag = _imageFlag;
@synthesize countryTitle = _countryTitle;
@synthesize policeNumber = _policeNumber;
@synthesize medicalNumber = _medicalNumber;
@synthesize fireNumber = _fireNumber;
@synthesize notesText = _notesText;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
        CountryOM * detailCountry = self.detailItem;
        
        self.imageFlag.image = detailCountry.flag;
        self.countryTitle.text = detailCountry.country;
        self.policeNumber.text = [NSString stringWithFormat:@"%@", detailCountry.police];
        self.medicalNumber.text = [NSString stringWithFormat:@"%@", detailCountry.medical];
        self.fireNumber.text = [NSString stringWithFormat:@"%@", detailCountry.fire];
        self.notesText.text = detailCountry.notes;
        
        //NSLog(@"Police: %@", detailCountry.police);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setImageFlag:nil];
    [self setCountryTitle:nil];
    [self setPoliceNumber:nil];
    [self setMedicalNumber:nil];
    [self setFireNumber:nil];
    [self setNotesText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
