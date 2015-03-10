//
//  Categories.m
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "Categories.h"

@implementation Categories

@synthesize categoryDesc, categoryID, categoryName;

- (id)initWidthCategoryDesc: (NSString *)cDesc andcategoryName: (NSString *)cName andcategoryID: (NSString *)cID;
{
    self = [super init];
    if (self)
    {
        categoryDesc = cDesc;
        categoryName = cName;
        categoryID = cID;
    }
    
    return self;
}

@end
