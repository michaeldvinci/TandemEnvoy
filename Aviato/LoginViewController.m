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

@synthesize UIPassword, UIUsername, locatServ, loginButton, loginArray, jLoginArray, loginDict, jUserArray, userArray, userDict, user;

- (void)viewDidLoad {
    
    user = [User getInstance];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)loginClicked:(id)sender {
    
    [self createUser];
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

- (void)createUser {
    
    NSString *loginURL = [@"http://tandemenvoy.michaeldvinci.com/forum/userJSON.php?" stringByAppendingString:[[NSString alloc] initWithFormat:@"userName=%@&userPass=%@",[self.UIUsername text],[self.UIPassword text]]];
    
    NSURL *dataURL = [NSURL URLWithString:loginURL];
    NSData *loginData = [NSData dataWithContentsOfURL:dataURL];
    
    jUserArray = [NSJSONSerialization JSONObjectWithData:loginData options:kNilOptions error:nil];
    
    for (userDict in jUserArray) {
        NSString *userID = userDict[@"userID"];
    }
    
    user.name = [self.UIUsername text];
    user.ID = [[jUserArray objectAtIndex:0]objectForKey:@"userID"];

}

- (void)login {
    
    NSString *success = @"0";
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
    
    NSLog(@"URL: %@", loginURL);
    NSLog(@"Success: %@", success);
    
    if([success isEqualToString:(login)]) {
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }
    else {
        [self showAlert];
    }
}

@end
