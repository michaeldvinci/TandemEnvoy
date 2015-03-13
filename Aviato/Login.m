//
//  Login.m
//  Aviato
//
//  Created by Michael Vinci on 3/13/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "Login.h"

@implementation Login

@synthesize success;

- (id)initWidthSuccess: (NSString *)loginSuccess;
{
    self = [super init];
    if (self)
    {
        success = loginSuccess;
    }
    
    return self;
}

@end