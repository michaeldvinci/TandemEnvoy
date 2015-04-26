//
//  AddPostViewController2.m
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "AddPostViewController2.h"
#import "CatViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AddPostViewController2 () <AddPostViewController2Delegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet UILabel *address;
- (IBAction)getLocat:(id)sender;

@end

/*!
 *	Implements the Geolocation static variables
 */
@implementation AddPostViewController2 {
	CLLocationManager *manager;
	CLGeocoder *geocoder;
	CLPlacemark *placemark;
}

@synthesize user, categoryDesc, categoryName, endTime, postString;

- (void)viewDidLoad {
	[super viewDidLoad];

	User *user = [User getInstance];

	manager = [[CLLocationManager alloc] init];
	geocoder = [[CLGeocoder alloc] init];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

/*!
 *	Allows user to return to previous view
 *
 *	@param sender Sender is user
 */
- (IBAction)cancel:(id)sender {
	[self.delegate addPostViewController2DidCancel:self];
    
    CatViewController *cVC;
    
    [cVC.tableView reloadData];
}

/*!
 *	Allows user to return to previous view
 *
 *	@param sender Sender is user
 */
- (IBAction)done:(id)sender {
	[self.delegate addPostViewController2DidSave:self];
    
    CatViewController *cVC;
    
    [cVC.tableView reloadData];
}

/*!
 *	Does a location lookup and returns reverse geotagged location
 *
 *	@param sender Sender is user
 */
- (IBAction)getLocat:(id)sender {
	manager.delegate = self;

	manager.desiredAccuracy = kCLLocationAccuracyBest;

	if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
		[manager requestWhenInUseAuthorization];
	}
	[manager startUpdatingLocation];
}

/*!
 *	pulls proper variables and applys them to correct .php file and allows them to be posted
 *  to the DB if successful
 *
 *	@param sender Sender is user
 */
- (void)submitData:(id)sender {
    if ((int)endTime.text >= 0){
        
        NSLog(@"endTime = %@", endTime.text);
        NSString *myRequestString = [NSString stringWithFormat:@"categoryDesc=%@&categoryName=%@&categoryUser=%@&catEnd=%@", categoryDesc.text, categoryName.text, [[User getInstance] userName], endTime.text];
        
        NSLog(@"catEnd = %@", endTime.text);

        NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tandemenvoy.michaeldvinci.com/forum/create_cat2.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:myRequestData];
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:1];
        NSLog(@"%@", response);

        [self postMade];
    }
    else {
        [self wrongValue];
    }
}

- (void)isEmpty {
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Error!"
                          message:@"Post Title cannot be empty!"
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Dismiss", nil];
    
    alert.tag = 100;
    [alert show];
}

- (void)postMade {
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Success!"
                          message:@"New Post created"
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Dismiss", nil];
    
    alert.tag = 200;
    [alert show];
}

- (void)wrongValue {
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Wrong Value!"
                          message:@"Post duration cannot be negative!"
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Dismiss", nil];
    alert.tag = 300;
    [alert show];
}

- (void) alertView: (UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 200) {
        if (buttonIndex == 0) {
            [self.delegate addPostViewController2DidSave:self];
        }
    }
}

#pragma mark CLLocationManagerDelegate Methods

/*!
 *	allows to return error if fails
 *
 *	@param manager location manager object
 *	@param error   error returned if issue
 */
- (void)LocationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Error: %@", error);
	NSLog(@"Failed to get Location! :(");
}

/*!
 *	updates map location is geocoordinates change.
 *
 *	@param manager   location manager object
 *	@param locations location object
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	NSLog(@"Location: %@", [locations lastObject]);
	CLLocation *curLocat = [locations lastObject];

	[geocoder reverseGeocodeLocation:curLocat completionHandler: ^(NSArray *placemarks, NSError *error) {
	    if (error == nil && [placemarks count] > 0) {
	        placemark = [placemarks lastObject];

	        self.address.text = [NSString stringWithFormat:@"%@ %@\n%@, %@. %@\n%@",
	                             placemark.subThoroughfare, placemark.thoroughfare,
	                             placemark.locality, placemark.administrativeArea, placemark.postalCode,
	                             placemark.country];
		}
	    else {
	        NSLog(@"%@", error.debugDescription);
		}
	}];
}

@end
