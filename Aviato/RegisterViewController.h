//
//  RegisterViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/8/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterViewController;

@protocol RegisterViewControllerDelegate <NSObject>
- (void)registerViewControllerDidSave:(RegisterViewController *)controller;
- (void)registerViewControllerDidCancel:(RegisterViewController *)controller;

@end

@interface RegisterViewController : UIViewController;

@property (strong, nonatomic) IBOutlet UITextField *userPass;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userPassCheck;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;


@property(nonatomic, strong) id <RegisterViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)submitData:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end
