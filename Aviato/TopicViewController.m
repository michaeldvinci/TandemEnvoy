//
//  TopicViewController.m
//  Aviato
//
//  Created by Michael Vinci on 3/11/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "Posts.h"
#import "TopicViewController.h"
#import "CatViewController.h"

#define getDataURL @"http://tandemenvoy.michaeldvinci.com/forum/repliesJSON.php?rID="

@interface TopicViewController ()

@end

@implementation TopicViewController

@synthesize jsonArray3, topicArray, tableView, theData, refreshControl, subURL, textView, descText, user;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    user = [User getInstance];
    
    self.title = @"Replies to job";
    textView.text = descText;
        
    [self retrieveData];
    
    UITableViewController *tvController = [[UITableViewController alloc] init];
    tvController.tableView = self.tableView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(updateTable:) forControlEvents:UIControlEventValueChanged];
    tvController.refreshControl = self.refreshControl;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return topicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"topCell";
    UITableViewCell *topCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Posts *topObject;
    topObject = [topicArray objectAtIndex:[indexPath row]];
    
    topCell.textLabel.text = topObject.replyContent;
    topCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return topCell;
}

- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)updateTable:(UIRefreshControl *)rControl
{
    [self retrieveData];
    [self.tableView reloadData];
    
    [refreshControl endRefreshing];
}

#pragma mark -
#pragma mark Class Methods
- (void) retrieveData;
{    
    NSURL *url = [NSURL URLWithString:subURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    jsonArray3 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    topicArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < jsonArray3.count; i++)
    {
        NSString *rTopic = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyTopic"];
        NSString *rID = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyID"];
        NSString *rDate = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyDate"];
        NSString *rContent = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyContent"];
        NSString *rBy = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyBy"];
        
        [topicArray addObject:[[Posts alloc]initWidthReplyBy: rBy andreplyDate: rDate andreplyTopic: rTopic andreplyContent: rContent andreplyID: rID]];
    }
    [self.tableView reloadData];
}
 
@end
