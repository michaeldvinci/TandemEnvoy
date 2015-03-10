//
//  CategoryController.h
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryController : UITableViewController

@property (strong, nonatomic) CategoryController *catViewController;
@property (nonatomic, strong) NSMutableArray * jsonArray2;
@property (nonatomic, strong) NSMutableArray * categoryArray;

#pragma mark -
#pragma mark Class Methods
- (void) retrieveData;

@end
