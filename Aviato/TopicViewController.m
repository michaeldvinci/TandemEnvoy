//
//  TopicViewController.m
//  Aviato
//
//  Created by Michael Vinci on 3/11/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "TopicViewController.h"
#import "CatViewController.h"
#import "Posts.h"

#define getDataURL @"http://tandemenvoy.michaeldvinci.com/forum/repliesJSON.php"

@interface TopicViewController ()

@end

@implementation TopicViewController

@synthesize jsonArray3, topicArray, tableView, theData, refreshControl, passedData, topDict, topID, tDict;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //test to see what gets passed along
    NSLog(@"passed: %@", theData);
    
    self.title = @"Test replies";
    
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
    topObject = [topicArray objectAtIndex:indexPath.row] ;
    
    topCell.textLabel.text = topObject.replyContent;
    
    topCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return topCell;
}

- (void)tableView:(UITableView *)myTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //[self performSegueWithIdentifier: sender:self];
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
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    jsonArray3 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSError *error;
    tDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    for (topDict in tDict) {
        topID = topDict[@"replyTopic"];
        NSString *catDesc = topDict[@"categoryDesc"];
        NSString *catName = topDict[@"categoryName"];
    }
    
    topicArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < jsonArray3.count; i++)
    {
        NSString *rID = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyID"];
        NSString *rTopic = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyTopic"];
        NSString *rDate = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyDate"];
        NSString *rContent = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyContent"];
        NSString *rBy = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyBy"];
        
        [topicArray addObject:[[Posts alloc]initWidthReplyBy: rBy andreplyDate: rDate andreplyTopic: rTopic andreplyContent: rContent andreplyID: rID]];
    }
    
    [self.tableView reloadData];
}

/**
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goBack"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddPostViewController2 *addPostViewController2 = [navigationController viewControllers][0];
        addPostViewController2.delegate = self;
    }
}

#pragma mark - AddPostViewControllerDelegate

- (void)addPostViewController2DidCancel:(AddPostViewController2 *) controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addPostViewController2DidSave:(AddPostViewController2 *) controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
**/
 
@end
