//
//  Posts.h
//  Aviato
//
//  Created by Michael Vinci on 3/9/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Posts : NSObject

@property (strong, nonatomic) NSString *replyBy;
@property (strong, nonatomic) NSString *rBy;
@property (strong, nonatomic) NSString *replyContent;
@property (strong, nonatomic) NSString *replyDate;
@property (strong, nonatomic) NSString *replyID;
@property (strong, nonatomic) NSString *replyTopic;

#pragma mark -
#pragma mark Class Methods

- (id)initWidthReplyBy: (NSString *)rBy andreplyDate: (NSString *)rDate andreplyTopic: (NSString *)rTopic andreplyContent: (NSString *)rContent andreplyID: (NSString *)rID;

@end
