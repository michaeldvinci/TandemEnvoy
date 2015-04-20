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

/*!
 *	Creates a getter and a setter for each variable
 */
@synthesize UIPassword, UIUsername, locatServ, loginButton, jLoginArray, user, loginURL, credential, permanent;


/*!
 *	Initializes the ViewController and sets it so that there is no navigation bar for no accidental return to the Login
 *  Screen. Also hides back button as a second precaution.
 */
- (void)viewDidLoad {
	self.navigationController.navigationBar.hidden = YES;

	user = [User getInstance];

	[super viewDidLoad];

	self.navigationItem.hidesBackButton = YES;
}

/*!
 *	Checks to see upon view loading, if there was an error about memory allocation
 */
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

/*!
 *	When interacted with, it sends the 'userName' and 'userPass' to the login.php files to check for proper credentials
 *
 *	@param sender sender is the User
 */
- (IBAction)loginClicked:(id)sender {
	[self login];
}

/*!
 *	When interacted with, it changes the view to the RegisterNewAccount View
 *
 *	@param sender User is the sender
 */
- (IBAction)registerClicked:(id)sender {
	[self registerNew];
}

/*!
 *	If the incorrect credentials are returned, the alert will popup and inform the user
 */
- (void)showAlert {
	UIAlertView *alert = [[UIAlertView alloc]

	                      initWithTitle:@"Login Failure"
	                                message:@"Wrong username/password, please try again"
	                               delegate:nil
	                      cancelButtonTitle:@"Dismiss"
	                      otherButtonTitles:nil];

	[alert show];
}

/*!
 *	calls the 'registerMe' segue to change views
 */
- (void)registerNew {
	[self performSegueWithIdentifier:@"registerNew" sender:self];
}

/*!
 *	checks for proper credentials and determines if the user moves to the next view or not
 */
- (void)login {
	NSURL *feedsURL = [NSURL URLWithString:@"http://tandemenvoy.michaeldvinci.com/forum/signin2.php"];

	NSString *userName = self.UIUsername.text;
	NSString *userPass = self.UIPassword.text;

	credential = [NSURLCredential credentialWithUser:userName
	                                        password:userPass
	                                     persistence:1];

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
	user.userID = [[jLoginArray objectAtIndex:0]objectForKey:@"userID"];

	NSString *success = [[jLoginArray objectAtIndex:0] objectForKey:@"success"];

	if ([success isEqualToString:@"1"]) {
		[self performSegueWithIdentifier:@"login_success" sender:self];

		[self test];
	}
	else {
		[self showAlert];
	}
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

@end
