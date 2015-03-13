//
//  LoginViewController.m
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "LoginViewController.h"
#import "Login.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize UIPassword, UIUsername, locatServ, loginButton, loginArray, jLoginArray, locationManager, loginDict;

- (void)viewDidLoad {
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500;
    [locationManager startUpdatingLocation];
    
    [super viewDidLoad];
}

- (void)locationManager:(CLLocationManager *)manager

    didUpdateLocations:(NSArray *)locations {
    }

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //NSLog(@"%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(id)sender {
    
    NSString *success = @"0";
    NSString *failure = @"0";
    NSString *login = @"1";

    NSString *loginURL = [@"http://tandemenvoy.michaeldvinci.com/forum/mobileSignin.php?" stringByAppendingString:[[NSString alloc] initWithFormat:@"userName=%@&userPass=%@",[self.UIUsername text],[self.UIPassword text]]];
    
    NSURL *dataURL = [NSURL URLWithString:loginURL];
    NSData *loginData = [NSData dataWithContentsOfURL:dataURL];
    
    jLoginArray = [NSJSONSerialization JSONObjectWithData:loginData options:kNilOptions error:nil];
    
    for (loginDict in jLoginArray) {
        NSString *success = loginDict[@"success"];
    }
    
    loginArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < jLoginArray.count; i++)
    {
        NSString *loginSuccess = [[jLoginArray objectAtIndex:i] objectForKey:@"success"];
        
        [loginArray addObject:[[Login alloc]initWidthSuccess: loginSuccess]];
    }
    
    success = [[jLoginArray objectAtIndex:0]objectForKey:@"success"];
    
    NSLog(@"Success: %@", success);
    
    if([success isEqualToString:(login)]) {
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }
    else {
        [self showAlert];
    }
}

- (void) showAlert {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Login Failure"
                          message:@"Wrong username/password, please try again"
                          delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil];
    
    [alert show];
}

@end
