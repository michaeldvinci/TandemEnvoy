//
//  AddCommentViewController.m
//  Aviato
//
//  Created by Michael Vinci on 4/7/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "RepoViewController.h"
#import "AddCommentViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AddCommentViewController () <AddCommentViewControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet UILabel *address2;
- (IBAction)getLocat:(id)sender;

@end

@implementation AddCommentViewController {
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@synthesize user, commentView, postString, tID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(id)sender {
    [self.delegate addCommentViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [self.delegate addCommentViewControllerDidSave:self];
}

- (IBAction)getLocat:(id)sender {
    manager.delegate = self;
    
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [manager requestWhenInUseAuthorization];
    }
    [manager startUpdatingLocation];
}

- (void) submitData:(id)sender {
    //topicCat = [[User sharedUser] user.userID];
    
    User *user1 = [User getInstance];
    
    NSString *myRequestString = [NSString stringWithFormat:@"replyContent=%@&replyBy=%@&replyTopic%@", commentView.text, user1.userID, tID];
    
    NSLog(@"Link: %@", myRequestString);
    
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://tandemenvoy.michaeldvinci.com/forum/create_reply2.php"]];
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody: myRequestData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:1];
    NSLog(@"%@",response);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark CLLocationManagerDelegate Methods

- (void)LocationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get Location! :(");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Location: %@", [locations lastObject]);
    CLLocation *curLocat = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:curLocat completionHandler: ^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            self.address2.text = [NSString stringWithFormat:@"%@ %@\n%@, %@. %@\n%@",
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

