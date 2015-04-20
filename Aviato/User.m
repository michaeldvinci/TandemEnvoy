//
//  User.m
//  Aviato
//
//  Created by Michael Vinci on 3/14/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"

/*!
 *	Implements the User header
 */
@implementation User

/*!
 *	synthesizes and sets userID variable
 */
@synthesize userID = _userID;

/*!
 *	synthesizes and sets userName variable
 */
@synthesize userName = _userName;

/*!
 *	sets static User Singleton for use
 */
static User *getInstance = nil;

/*!
 *	return instance of User Singleton
 *
 *	@return 'User' Singleton
 */
+ (User *)getInstance {
	if (getInstance == nil) {
		getInstance = [[User alloc] init];
	}

	return getInstance;
}

/*!
 *	initializes 'User' singleton to return value
 *
 *	@return 'User' singleton
 */
- (id)init {
	if (self = [super init]) {
		_userID = @"";
	}

	return self;
}

/*!
 *	sets 'userID' when called upon
 *
 *	@param ID 'userID' from DB
 */
- (void)setID:(NSString *)ID {
	_userID = ID;
}

/*!
 *	returns 'userID' when called upon
 *
 *	@return 'userID' when called upon
 */
- (NSString *)ID {
	return _userID;
}

/*!
 *	sets 'userName' when called upon
 *
 *	@param name 'userName' from DB
 */
- (void)setName:(NSString *)name {
	_userName = name;
}

/*!
 *	returns 'userName' when called upon
 *
 *	@return 'userName' when called upon
 */
- (NSString *)name {
	return _userName;
}

@end
