//
//  RegisterViewController.m
//  Aviato
//
//  Created by Michael Vinci on 4/8/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "RepoViewController.h"
#import "RegisterViewController.h"

@interface RegisterViewController() <RegisterViewControllerDelegate>

@end

@implementation RegisterViewController {
}

@synthesize userName, userPass, userEmail, userPassCheck;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(id)sender {
    [self.delegate registerViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [self.delegate registerViewControllerDidSave:self];
}

- (void) submitData:(id)sender {
    //topicCat = [[User sharedUser] user.userID];
    
    if ([self.userPass.text isEqualToString:self.userPassCheck.text]) {
    
        User *user1 = [User getInstance];
    
        NSString *myRequestString = [NSString stringWithFormat:@"userName=%@&userPass=%@&userEmail%@", userName.text, userPass.text, userEmail.text];
    
        NSLog(@"Link: %@", myRequestString);
    
        NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://    tandemenvoy.michaeldvinci.com/forum/iosSignup.php"]];
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody: myRequestData];
        NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
        NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:1];
        NSLog(@"%@",response);
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end