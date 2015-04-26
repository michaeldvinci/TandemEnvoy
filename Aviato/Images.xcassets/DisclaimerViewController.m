//
//  DisclaimerViewController.m
//  Aviato
//
//  Created by Michael Vinci on 4/22/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "DisclaimerViewController.h"

@interface DisclaimerViewController ()

@end

@implementation DisclaimerViewController {
    
}

- (IBAction)disagreeClicked:(id)sender {
    [self exitApp];
}

- (void)exitApp {
    exit(0);
}

@end