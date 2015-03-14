//
//  LoginViewController.h
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet UITextField *UIUsername;
@property (weak, nonatomic) IBOutlet UITextField *UIPassword;
@property (nonatomic, strong) NSString *locatServ;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) NSMutableArray *jLoginArray;
@property (nonatomic, strong) NSMutableArray *loginArray;
@property (nonatomic, strong) NSDictionary *loginDict;
@property (nonatomic, strong) NSMutableArray *jUserArray;
@property (nonatomic, strong) NSMutableArray *userArray;
@property (nonatomic, strong) NSDictionary *userDict;


- (IBAction)loginClicked:(id)sender;

@end
