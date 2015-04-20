//
//  RegisterViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/8/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterViewController;

/*!
 *	Sets up the didSave and didCancel methods, allowing for return to previous View Controller
 *  when finished with the current one.
 */
@protocol RegisterViewControllerDelegate <NSObject>
- (void)registerViewControllerDidSave:(RegisterViewController *)controller;
- (void)registerViewControllerDidCancel:(RegisterViewController *)controller;

@end

@interface RegisterViewController : UIViewController;

/*!
 *	TF source for userPass variable
 */
@property (strong, nonatomic) IBOutlet UITextField *userPass;

/*!
 *	TF source for userName variable
 */
@property (strong, nonatomic) IBOutlet UITextField *userName;

/*!
 *	TF source for userPassCheck variable
 */
@property (strong, nonatomic) IBOutlet UITextField *userPassCheck;

/*!
 *	TF source for userEmail variable
 */
@property (strong, nonatomic) IBOutlet UITextField *userEmail;


@property (nonatomic, strong) id <RegisterViewControllerDelegate> delegate;

/*!
 *	Returns user to previous view
 *
 *	@param sender Sender is user
 */
- (IBAction)cancel:(id)sender;

/*!
 *	Returns user to previous view
 *
 *	@param sender Sender is user
 */
- (IBAction)done:(id)sender;

/*!
 *	pulls data and sends it to the DB using the correct .php file
 *
 *	@param sender Sender is user
 */
- (IBAction)submitData:(id)sender;

/*!
 *	Dismisses keyboard upon pressing the [Return] key
 *
 *	@param sender Sender is user
 */
- (IBAction)textFieldReturn:(id)sender;

@end
