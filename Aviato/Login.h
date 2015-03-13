//
//  Login.h
//  Aviato
//
//  Created by Michael Vinci on 3/13/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

@property (strong, nonatomic) NSString *success;

#pragma mark -
#pragma mark Class Methods

- (id)initWidthSuccess:(NSString*) loginSuccess;

@end