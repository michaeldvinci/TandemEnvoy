//
//  CatViewController.h
//  Aviato
//
//  Created by Michael Vinci on 3/11/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPostViewController2.h"

@interface CatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddPostViewController2Delegate> {
	/*!
	 *	tableView which allows for the population of JSON data into tableviewcells
	 */
	IBOutlet UITableView *tableView;

	/*!
	 *	Array which JSON data is populated into
	 */
	NSMutableArray *categoryArray;

	/*!
	 *	Data variable for JSON response
	 */
	NSMutableData *responseData;
}

/*!
 *	User singleton
 */
@property (nonatomic, strong) User *user;

/*!
 *	catviewcontroller object
 */
@property (nonatomic, strong) CatViewController *catViewController;

/*!
 *	jsonArray for JSON data
 */
@property (nonatomic, strong) NSArray *jsonArray2;

/*!
 *	array for data
 */
@property (nonatomic, strong) NSMutableArray *categoryArray;

/*!
 *	tableview for populated data
 */
@property (nonatomic, strong) IBOutlet UITableView *tableView;

/*!
 *	allows for drag-to-refresh within the uitableview
 */
@property (nonatomic, strong) UIRefreshControl *refreshControl;

#pragma mark -
#pragma mark Class Methods
- (void)retrieveData;

@end
