//
//  RepoViewController.h
//  Aviato
//
//  Created by Michael Vinci on 3/14/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPostViewController2.h"

@interface RepoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddPostViewController2Delegate> {
    
    IBOutlet UITableView *tableView;
    NSMutableArray *repoArray;
}

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) RepoViewController *repoViewController;
@property (nonatomic, strong) AddPostViewController2 *AddPostController;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextView *repoTF;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, retain) NSDictionary *theData2;
@property (nonatomic, retain) NSString *descText2;
@property (nonatomic, retain) NSString *subURL2;
@property (nonatomic, strong) NSMutableArray *repoJsonArray;
@property (nonatomic, strong) NSMutableArray *repoArray;

#pragma mark -
#pragma mark Class Methods
- (void) retrieveData;

@end
