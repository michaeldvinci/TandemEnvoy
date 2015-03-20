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

@synthesize UIPassword, UIUsername, locatServ, loginButton, jLoginArray, user, loginURL, credential, permanent;

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
    
    NSURL *feedsURL = [NSURL URLWithString:@"http://tandemenvoy.michaeldvinci.com/forum/signin2.php"];
    
    NSString *userName = self.UIUsername.text;
    NSString *userPass = self.UIPassword.text;
    
    credential = [NSURLCredential credentialWithUser: userName
                                            password: userPass
                                         persistence: nil];
    
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc]
                                             initWithHost:@"http://tandemenvoy.michaeldvinci.com/forum/signin2.php"
                                             port:0
                                             protocol:@"http"
                                             realm:nil
                                             authenticationMethod:nil];
    
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential
                                                        forProtectionSpace:protectionSpace];
    
    loginURL = [@"http://tandemenvoy.michaeldvinci.com/forum/mobileSignin.php?" stringByAppendingString:[[NSString alloc] initWithFormat:@"userName=%@&userPass=%@", userName, userPass]];
    
    NSURL *dataURL = [NSURL URLWithString:loginURL];
    NSData *loginData = [NSData dataWithContentsOfURL:dataURL];
    
    jLoginArray = [NSJSONSerialization JSONObjectWithData:loginData options:kNilOptions error:nil];
    
    user.userName = userName;
    user.ID = [[jLoginArray objectAtIndex:0]objectForKey:@"userID"];
    user.level = [[jLoginArray objectAtIndex:0]objectForKey:@"userLevel"];
    
    if(credential) {
        [self performSegueWithIdentifier:@"login_success" sender:self];
        
        [self test];
    }
    else {
        [self showAlert];
    }
    
}

- (void) test {
    NSLog(@" ");
    NSLog(@"----------------------");
    NSLog(@"User Name: %@", user.userName);
    NSLog(@"User ID: %@",user.userID);
    NSLog(@"User Level: %@",user.userLevel);
    NSLog(@"----------------------");
    NSLog(@" ");
}

@end
