//
//  User.h
//  Aviato
//
//  Created by Michael Vinci on 3/14/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <foundation/Foundation.h>

/*!
 *	Instantiates User singleton
 */
@interface User : NSObject {
	NSString *_userID;
	NSString *_userName;
}

/*!
 *	Singleton variable to hold userId througout the program
 *
 *  @warning 'userID' must not be null.
 */
@property (nonatomic, strong) NSString *userID;

/*!
 *	Singleton variable to hold userName throughout the program
 *
 *  @warning 'userName' must not be null
 */
@property (nonatomic, strong) NSString *userName;

/*!
 *	Instantiates a User Singleton
 *
 *	@return returns a User object for access through the application
 */
+ (User *)getInstance;

/*!
 *	sets User Singleton 'userID' variable
 *
 *	@param userID userID based on database information
 */
- (void)setID:(NSString *)userID;

/*!
 *	returns userID when called upon
 *
 *	@return userID based on database information
 */
- (NSString *)userID;

/*!
 *	sets User Singleton 'userName' variable
 *
 *	@param userName userName based on database information
 */
- (void)setName:(NSString *)userName;

/*!
 *	returns userName when called upon
 *
 *	@return userName based on database information
 */
- (NSString *)userName;

@end
