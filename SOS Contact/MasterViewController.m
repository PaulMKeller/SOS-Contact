//
//  MasterViewController.m
//  SOS Contact
//
//  Created by Paul Keller on 24/08/2012.
//  Copyright (c) 2012 Planet K Games. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController
@synthesize locationManager;
@synthesize detailViewController = _detailViewController;
//@synthesize locationManager;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    sharedDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [self setLocationManager:nil];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.detailViewController=segue.destinationViewController;
}

#pragma TableView Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sharedDelegate.countriesArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Country";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"countryCell"];
    
    CountryOM * country = [sharedDelegate.countriesArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = country.country;
    
    UIImage * flag;
    flag = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", cell.textLabel.text, @".png"]];
    cell.imageView.image = flag;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CountryOM * selectedCountry = [sharedDelegate.countriesArray objectAtIndex: indexPath.row];
    DetailViewController * sharedController = self.detailViewController;
    
    [sharedController setDetailItem:selectedCountry];
    
}

#pragma Geolocation Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [manager stopUpdatingLocation];
    
    NSLog(@"Location: %@", [newLocation description]);
    
    __block BOOL isCountryFound = NO;
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            //currentCountry.text = [placemark country];
            
            NSInteger myIndex = 0;
            for (CountryOM * localCountry in sharedDelegate.countriesArray) {
                if ([localCountry.country isEqualToString:[placemark country]]) {
                    isCountryFound = YES;
                    //NSLog(@"Country: %@", currentCountry.text);                    
                    
                    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:(myIndex) inSection:0];
                    [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    
                    break;
                }
                
                if (isCountryFound == YES) {
                    break;
                }
                
                myIndex++;
            }
            
            if (isCountryFound == YES) {
                break;
            }
        }    
    }];
    
//    if (isCountryFound == NO) {
//        //don't do anything for the time being.
//    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error description]);
}





@end
