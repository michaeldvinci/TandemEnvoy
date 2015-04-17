//
//  PaymentViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/17/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *invoiceName;
@property (weak, nonatomic) IBOutlet UITextField *invoiceDesc;
@property (weak, nonatomic) IBOutlet UITextField *invoiceAmount;
@property (weak, nonatomic) IBOutlet UITextField *invoiceEmail;

- (IBAction)openPayPal:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end