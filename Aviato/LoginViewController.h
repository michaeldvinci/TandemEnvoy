//
//  LoginViewController.h
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *UIUsername;
@property (weak, nonatomic) IBOutlet UITextField *UIPassword;

- (IBAction)loginClicked:(id)sender;

@end
