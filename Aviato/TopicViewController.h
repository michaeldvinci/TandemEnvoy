//
//  TopicViewController.h
//  Aviato
//
//  Created by Michael Vinci on 3/11/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCommentViewController.h"

@interface TopicViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddCommentViewControllerDelegate> {
    
    IBOutlet UITableView *tableView;
    NSMutableArray *topicArray;
}

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) TopicViewController *topViewController;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, retain) NSDictionary *theData;
@property (nonatomic, retain) NSString *subURL;
@property (nonatomic, retain) NSString *topID;
@property (nonatomic, retain) NSString *descText;
@property (nonatomic, strong) NSMutableArray *jsonArray3;
@property (nonatomic, strong) NSMutableArray *topicArray;

#pragma mark -
#pragma mark Class Methods

- (void) retrieveData;

@end
