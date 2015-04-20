//
//  Posts.h
//  Aviato
//
//  Created by Michael Vinci on 3/9/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *	Interface declaration of categories
 */
@interface Posts : NSObject


@property (strong, nonatomic) NSString *replyBy;
@property (strong, nonatomic) NSString *rBy;
@property (strong, nonatomic) NSString *replyContent;
@property (strong, nonatomic) NSString *replyDate;
@property (strong, nonatomic) NSString *replyID;
@property (strong, nonatomic) NSString *replyTopic;
@property (strong, nonatomic) NSString *replyUser;

#pragma mark -
#pragma mark Class Methods

/*!
 *	initalizes the reply data for use in the JSON parsing
 *
 *	@param rBy      replyBy data
 *	@param rDate    replyDate data
 *	@param rTopic   replyTopic data
 *	@param rContent replyContent data
 *	@param rID      replyID data
 *  @param rUser    replyUser data
 *
 *	@return returns Reply object
 */
- (id)initWidthReplyBy: (NSString *)rBy andreplyDate: (NSString *)rDate andreplyTopic: (NSString *)rTopic andreplyContent: (NSString *)rContent andreplyID: (NSString *)rID andreplyUser: (NSString *) rUser;

@end
