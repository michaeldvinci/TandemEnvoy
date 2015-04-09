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

@interface RegisterViewController : UITableViewController;

@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *userPass;
@property (nonatomic, strong) UILabel *userEmail;

@property(nonatomic, weak) id <RegisterViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)submitData:(id)sender;

@end
