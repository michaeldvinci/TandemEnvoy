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
    
    IBOutlet UITableView *tableView;
    NSMutableArray *categoryArray;
    NSMutableData *responseData;
}

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) CatViewController *catViewController;
@property (nonatomic, strong) NSArray *jsonArray2;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

#pragma mark -
#pragma mark Class Methods
- (void) retrieveData;

@end
