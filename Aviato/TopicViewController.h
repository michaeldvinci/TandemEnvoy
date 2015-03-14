//
//  TopicViewController.h
//  Aviato
//
//  Created by Michael Vinci on 3/11/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *tableView;
    NSMutableArray *topicArray;
}

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) TopicViewController *topViewController;
@property (nonatomic, strong) NSMutableArray *jsonArray3;
@property (nonatomic, strong) NSMutableArray *topicArray;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) IBOutlet NSDictionary *topDict;
@property (nonatomic, retain) NSDictionary *theData;
@property (nonatomic, retain) NSString *subURL;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, retain) NSString *descText;

#pragma mark -
#pragma mark Class Methods

- (void) retrieveData;

@end
