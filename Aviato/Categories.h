//
//  Categories.h
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categories : NSObject

@property (strong, nonatomic) NSString *categoryDesc;
@property (strong, nonatomic) NSString *categoryID;
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSString *categoryUser;

#pragma mark -
#pragma mark Class Methods

/*!
 *	initializes category data for use in the JSON parsing
 *
 *	@param cDesc category Description data
 *	@param cName Category Name data
 *	@param cID   Category ID data
 *	@param cUser Category User data
 *
 *	@return returns Category object
 */
- (id)initWidthCategoryDesc:(NSString *)cDesc andcategoryName:(NSString *)cName andcategoryID:(NSString *)cID andcategoryUser:(NSString *)cUser;

@end
