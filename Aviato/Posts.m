//
//  Posts.m
//  Aviato
//
//  Created by Michael Vinci on 3/9/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "Posts.h"

@implementation Posts

@synthesize replyBy, replyContent, replyDate, replyID, replyTopic, replyUser;

- (id)initWidthReplyBy: (NSString *)rBy andreplyDate: (NSString *)rDate andreplyTopic: (NSString *)rTopic andreplyContent: (NSString *)rContent andreplyID: (NSString *)rID andreplyUser: (NSString *) rUser;
{
    self = [super init];
    if (self)
    {
             replyBy = rBy;
           replyDate = rDate;
          replyTopic = rTopic;
        replyContent = rContent;
             replyID = rID;
           replyUser = rUser;
    }
    
    return self;
}

@end
