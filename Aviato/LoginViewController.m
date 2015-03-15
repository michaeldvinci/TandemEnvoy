//
//  LoginViewController.m
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "Login.h"
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize UIPassword, UIUsername, locatServ, loginButton, jLoginArray, user, loginURL;

- (void)viewDidLoad {
    
    user = [User getInstance];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)loginClicked:(id)sender {
    
    [self login];
    
    }

- (void)showAlert {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"Login Failure"
                          message:@"Wrong username/password, please try again"
                          delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)login {
    
    NSString *success = @"0";
    NSString *login = @"1";
    
    loginURL = [@"http://tandemenvoy.michaeldvinci.com/forum/mobileSignin.php?" stringByAppendingString:[[NSString alloc] initWithFormat:@"userName=%@&userPass=%@",[self.UIUsername text],[self.UIPassword text]]];
    
    NSURL *dataURL = [NSURL URLWithString:loginURL];
    NSData *loginData = [NSData dataWithContentsOfURL:dataURL];
    
    jLoginArray = [NSJSONSerialization JSONObjectWithData:loginData options:kNilOptions error:nil];
    
    user.ID = [[jLoginArray objectAtIndex:0]objectForKey:@"userID"];
    user.level = [[jLoginArray objectAtIndex:0]objectForKey:@"userLevel"];
    user.name = [self.UIUsername text];
    
    success = [[jLoginArray objectAtIndex:0]objectForKey:@"success"];
    
    if([success isEqualToString:(login)]) {
        [self performSegueWithIdentifier:@"login_success" sender:self];
        NSURLCredential *credential;
    
        [self test];
    }
    else {
        [self showAlert];
    }
}

- (void) test {
    NSLog(@" ");
    NSLog(@"----------------------");
    NSLog(@"URL: %@", loginURL);
    NSLog(@" ");
    NSLog(@"User Name: %@", user.userName);
    NSLog(@"User ID: %@",user.userID);
    NSLog(@"User Level: %@",user.userLevel);
    NSLog(@"----------------------");
    NSLog(@" ");
}

@end
