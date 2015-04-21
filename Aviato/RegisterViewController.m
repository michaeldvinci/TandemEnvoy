//
//  RegisterViewController.m
//  Aviato
//
//  Created by Michael Vinci on 4/8/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "RepoViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface RegisterViewController () <RegisterViewControllerDelegate>

@end

@implementation RegisterViewController {
}

@synthesize userName, userPass, userEmail, userPassCheck, user;

- (void)viewDidLoad {
	[super viewDidLoad];
    
    user = [User getInstance];
}

- (IBAction)textFieldReturn:(id)sender {
	[sender resignFirstResponder];
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
	[self.delegate registerViewControllerDidCancel:self];
}

/*!
 *	Allows user to return to previous view
 *
 *	@param sender Sender is user
 */
- (IBAction)done:(id)sender {
	[self.delegate registerViewControllerDidSave:self];
}

/*!
 *	test method to see what variables are being returned
 */
- (void)test {
    NSLog(@" ");
    NSLog(@"----------------------");
    NSLog(@"User Name: %@", user.userName);
    NSLog(@"User ID: %@", user.userID);
    NSLog(@"----------------------");
    NSLog(@" ");
}

/*!
 *	Shows alert when Successful user added to DB
 */
- (void)showAlert1 {
	UIAlertView *alert1 = [[UIAlertView alloc]

	                      initWithTitle:@"Successful"
	                                message:@"New user registered!"
	                               delegate:self
	                      cancelButtonTitle:nil
	                      otherButtonTitles:@"OK", nil];
    alert1.tag = 100;
	[alert1 show];
}

- (void) alertView: (UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            [self login];
            [self test];
        }
    }
}

/*!
 *	Shows alert when failure at adding new user
 */
- (void)showAlert2 {
	UIAlertView *alert2 = [[UIAlertView alloc]

	                      initWithTitle:@"Failure"
	                                message:@"Registration attempt failed, try again"
	                               delegate:nil
	                      cancelButtonTitle:@"Dismiss"
	                      otherButtonTitles:nil];

	[alert2 show];
}

/*!
 *	Shows alert if there is already a user with the same name in the DB
 */
- (void)showAlert3 {
	UIAlertView *alert3 = [[UIAlertView alloc]

	                      initWithTitle:@"Failure"
	                                message:@"userName already taken, try again"
	                               delegate:nil
	                      cancelButtonTitle:@"Dismiss"
	                      otherButtonTitles:nil];

	[alert3 show];
}

- (void)login {
    NSString *loginURL = [@"http://tandemenvoy.michaeldvinci.com/forum/mobileSignin.php?" stringByAppendingString:[[NSString alloc] initWithFormat:@"userName=%@&userPass=%@", userName.text, userPass.text]];
    
    NSURL *dataURL = [NSURL URLWithString:loginURL];
    NSData *loginData = [NSData dataWithContentsOfURL:dataURL];
    
    NSMutableArray *jLoginArray = [NSJSONSerialization JSONObjectWithData:loginData options:kNilOptions error:nil];
    
    user.userName = userName.text;
    user.userID = [[jLoginArray objectAtIndex:0]objectForKey:@"userID"];
    
    NSString *success = [[jLoginArray objectAtIndex:0] objectForKey:@"success"];
    
    if ([success isEqualToString:@"1"]) {
        [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    }

}

/*!
 *
 *
 *	Takes 3 variables from TF and submits them to the .php file and attempts to add a new user to the DB
 *
 *  if successful, shows alert1, if not it shows alert2
 *
 *
 *  Afterwards, closes view and returns to Login screen
 *
 *
 *
 *	@param sender Sender is user
 */
- (void)submitData:(id)sender {
	//topicCat = [[User sharedUser] user.userID];

	User *user1 = [User getInstance];

    if ([userPass.text isEqualToString:userPassCheck.text]) {
        NSString *emailString = [userEmail.text stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
        emailString = [emailString stringByReplacingOccurrencesOfString:@"." withString:@"%2E"];

        NSString *myRequestString = [NSString stringWithFormat:@"userName=%@&userPass=%@&userEmail=%@", userName.text, userPass.text, emailString];

        NSLog(@"Link: %@", myRequestString);

        NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tandemenvoy.michaeldvinci.com/forum/iosSignup.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody:myRequestData];
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:1];
        NSLog(@"%@", response);

        NSArray *registerArray = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];

        NSString *success = [[registerArray objectAtIndex:0] objectForKey:@"success"];

        if ([success isEqualToString:@"1"]) {
            [self showAlert1];
        }
        else if ([success isEqualToString:@"0"]) {
            [self showAlert2];
        }
        else {
            [self showAlert3];
        }
    }
    
    
	[self.navigationController popViewControllerAnimated:YES];
}

@end
