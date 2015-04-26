//
//  DisclaimerViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/22/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisclaimerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *noAgree;

- (IBAction)disagreeClicked:(id)sender;

@end

