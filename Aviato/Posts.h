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

/*!
 *	<#Description#>
 */
@property (strong, nonatomic) NSString *replyBy;

/*!
 *	<#Description#>
 */
@property (strong, nonatomic) NSString *rBy;

/*!
 *	<#Description#>
 */
@property (strong, nonatomic) NSString *replyContent;

/*!
 *	<#Description#>
 */
@property (strong, nonatomic) NSString *replyDate;

/*!
 *	<#Description#>
 */
@property (strong, nonatomic) NSString *replyID;

/*!
 *	<#Description#>
 */
@property (strong, nonatomic) NSString *replyTopic;
@property (strong, nonatomic) NSString *replyUser;
#pragma mark -
#pragma mark Class Methods

/*!
 *	<#Description#>
 *
 *	@param rBy      <#rBy description#>
 *	@param rDate    <#rDate description#>
 *	@param rTopic   <#rTopic description#>
 *	@param rContent <#rContent description#>
 *	@param rID      <#rID description#>
 *
 *	@return <#return value description#>
 */
- (id)initWidthReplyBy: (NSString *)rBy andreplyDate: (NSString *)rDate andreplyTopic: (NSString *)rTopic andreplyContent: (NSString *)rContent andreplyID: (NSString *)rID andreplyUser: (NSString *) rUser;

@end
