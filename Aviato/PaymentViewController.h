//
//  PaymentViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/17/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *invoiceName;
@property (strong, nonatomic) IBOutlet UITextField *invoiceDesc;
@property (strong, nonatomic) IBOutlet UITextField *invoiceAmount;
@property (strong, nonatomic) IBOutlet UITextField *invoiceEmail;

/*!
 *	opens PayPal Here app when called upon
 *
 *	@param sender Sender is User
 */
- (IBAction)openPayPal:(id)sender;

/*!
 *	allows for dismissal of keyboard upon use of [return] key
 *
 *	@param sender Sender is User
 */
- (IBAction)textFieldReturn:(id)sender;

@end
