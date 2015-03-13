//
//  LoginViewController.h
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LoginViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *UIUsername;
@property (weak, nonatomic) IBOutlet UITextField *UIPassword;
@property (nonatomic, strong) NSString *locatServ;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *jLoginArray;
@property (nonatomic, strong) NSMutableArray *loginArray;
@property (nonatomic, strong) NSDictionary *loginDict;


- (IBAction)loginClicked:(id)sender;

@end
