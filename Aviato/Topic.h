//
//  Topic.h
//  Aviato
//
//  Created by Michael Vinci on 3/12/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (strong, nonatomic) NSString *topicBy;
@property (strong, nonatomic) NSString *topicCat;
@property (strong, nonatomic) NSString *topicDate;
@property (strong, nonatomic) NSString *topicID;
@property (strong, nonatomic) NSString *topicSubject;
@property (strong, nonatomic) NSString *topicUser;

#pragma mark -
#pragma mark Class Methods

/*!
 *	initializes topic data for use in the JSON parsing
 *
 *	@param reID      topicID data
 *	@param reCat     topicCategory data
 *	@param reDate    topicDate data
 *	@param reBy      topicBy data
 *	@param reSubject topicSubject data
 *	@param reUser    topicUser data
 *
 *	@return returns Topic object
 */
- (id)initWidthTopicID:(NSString *)reID andtopicCat:(NSString *)reCat andtopicDate:(NSString *)reDate andtopicBy:(NSString *)reBy andtopicSubject:(NSString *)reSubject andtopicUser:(NSString *)reUser;

@end
