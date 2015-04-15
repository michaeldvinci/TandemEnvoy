//
//  Login.h
//  Aviato
//
//  Created by Michael Vinci on 3/13/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

/*!
 *	the 'success' variable is a static variable to test against for credentials
 */
@property (strong, nonatomic) NSString *success;

#pragma mark -
#pragma mark Class Methods

/*!
 *	Checks to see what was returned via JSON data from login attempt
 *
 *	@param loginSuccess variable to test against
 *
 *	@return returned JSON parameter
 */
- (id)initWidthSuccess:(NSString*) loginSuccess;

@end