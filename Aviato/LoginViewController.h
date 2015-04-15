//
//  LoginViewController.h
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *	LoginViewController object to allow setting of LVC objects during degue
 */
@interface LoginViewController : UIViewController

/*!
 *	User singleton that returns user data
 */
@property (nonatomic, strong) User *user;

/*!
 *	Text Field from which login userName is pulled
 */
@property (weak, nonatomic) IBOutlet UITextField *UIUsername;

/*!
 *	Text Field from which login userPass is pulled
 */
@property (weak, nonatomic) IBOutlet UITextField *UIPassword;

/*!
 *	variable for location service to be called upon
 */
@property (nonatomic, strong) NSString *locatServ;

/*!
 *	Button which initiates the loginClicked IBAction
 */
@property (nonatomic, strong) IBOutlet UIButton *loginButton;

/*!
 *	JSON array of login crendentials
 */
@property (nonatomic, strong) NSMutableArray *jLoginArray;

/*!
 *	URL of which to connect to .php file
 */
@property (nonatomic, strong) NSString *loginURL;

/*!
 *	Credentials for JSON data and $_POST request
 */
@property (nonatomic, strong) NSURLCredential *credential;

/*!
 *	Credential persistence for session information
 */
@property (nonatomic) NSURLCredentialPersistence *permanent;

/*!
 *	when activated, it will send data to .php file to check for proper credentials to let the user log in, if 
 *  proper cred. are found, user will segue to the CatViewController
 *
 *	@param sender sender is the user data
 */
- (IBAction)loginClicked:(id)sender;

/*!
 *	when activated, it will send user to the RegisterViewController allowing them to sign up for a new account
 *
 *	@param sender sender is the user data
 */
- (IBAction)registerClicked:(id)sender;

@end
