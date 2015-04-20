//
//  Login.m
//  Aviato
//
//  Created by Michael Vinci on 3/13/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "Login.h"

@implementation Login

/*!
 *	makes getter/setter for variables
 */
@synthesize success;

/*!
 *	If proper login credentials, allows user to pass on to next view
 *
 *	@param loginSuccess test variable
 *
 *	@return JSON informatiom
 */
- (id)initWidthSuccess:(NSString *)loginSuccess;
{
	self = [super init];
	if (self) {
		success = loginSuccess;
	}

	return self;
}

@end
