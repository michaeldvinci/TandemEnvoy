//
//  Topic.m
//  Aviato
//
//  Created by Michael Vinci on 3/12/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "Topic.h"

@implementation Topic

@synthesize topicSubject, topicDate, topicBy, topicCat, topicID;

- (id)initWidthTopicID: (NSString *)reID andtopicCat: (NSString *)reCat andtopicDate: (NSString *)reDate andtopicBy: (NSString *)reBy andtopicSubject: (NSString *)reSubject;
{
    self = [super init];
    if (self)
    {
        topicSubject = reSubject;
        topicDate = reDate;
        topicBy = reBy;
        topicCat = reCat;
        topicID = reID;
    }
    
    return self;
}

@end