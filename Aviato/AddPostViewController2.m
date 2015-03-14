//
//  AddPostViewController2.m
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "AddPostViewController2.h"
#import <CoreLocation/CoreLocation.h>

@interface AddPostViewController2 () <AddPostViewController2Delegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet UILabel *address;
- (IBAction)getLocat:(id)sender;

@end

@implementation AddPostViewController2 {
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = [User getInstance];
    
    NSLog(@"postUN: %@",user.userName);
    NSLog(@"postUID: %@",user.userID);
    
    manager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(id)sender {
    [self.delegate addPostViewController2DidCancel:self];
}

- (IBAction)done:(id)sender {
    [self.delegate addPostViewController2DidSave:self];
}

- (IBAction)getLocat:(id)sender {
    manager.delegate = self;
    
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [manager requestWhenInUseAuthorization];
    }
    [manager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate Methods

- (void)LocationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get Location! :(");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Location: %@", [locations lastObject]);
    CLLocation *curLocat = [locations lastObject];
    
    if (curLocat != nil) {
        self.latitude.text = [NSString stringWithFormat:@"%.8f", curLocat.coordinate.latitude];
        self.longitude.text = [NSString stringWithFormat:@"%.8f", curLocat.coordinate.longitude];
    }
    
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
