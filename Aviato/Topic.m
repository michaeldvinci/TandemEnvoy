//
//  Topic.m
//  Aviato
//
//  Created by Michael Vinci on 3/12/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "Topic.h"

@implementation Topic

@synthesize topicSubject, topicDate, topicBy, topicCat, topicID, topicUser;

/*!
 *	initializes topic data for use in JSON parsing
 *
 *	@param reID      topicID variable
 *	@param reCat     topicCategory variable
 *	@param reDate    topicDate variable
 *	@param reBy      topicBy variable
 *	@param reSubject topicSubject variable
 *	@param reUser    topicUser variable
 *
 *	@return returns Topic object
 */
- (id)initWidthTopicID:(NSString *)reID andtopicCat:(NSString *)reCat andtopicDate:(NSString *)reDate andtopicBy:(NSString *)reBy andtopicSubject:(NSString *)reSubject andtopicUser:(NSString *)reUser;
{
	self = [super init];
	if (self) {
		topicID = reID;
		topicCat = reCat;
		topicDate = reDate;
		topicBy = reBy;
		topicSubject = reSubject;
		topicUser = reUser;
	}

	return self;
}

@end
