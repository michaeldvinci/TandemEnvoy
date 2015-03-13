//
//  CatViewController.m
//  Aviato
//
//  Created by Michael Vinci on 3/11/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "CatViewController.h"
#import "Categories.h"
#import "TopicViewController.h"

#define getDataURL @"http://tandemenvoy.michaeldvinci.com/forum/categoriesJSON.php"

@interface CatViewController ()

@end

@implementation CatViewController

@synthesize jsonArray2, categoryArray, tableView, refreshControl, catDict, dictArray, catID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Recent Posts";
    self.navigationItem.hidesBackButton = YES;
    
    [self retrieveData];
    
    UITableViewController *tvController = [[UITableViewController alloc] init];
    tvController.tableView = self.tableView;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(updateTable:) forControlEvents:UIControlEventValueChanged];
    tvController.refreshControl = self.refreshControl;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categoryArray.count; 
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"catCell";
    UITableViewCell *catCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Categories * catObject;
    catObject = [categoryArray objectAtIndex:indexPath.row] ;
    
    catCell.textLabel.text = catObject.categoryName;
    
    catCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return catCell;
}

- (void)tableView:(UITableView *)myTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    NSURL *url = [NSURL URLWithString:getDataURL];
    NSMutableData *responseData = [NSMutableData dataWithContentsOfURL:url];
    
    NSError *error;
    jsonArray2 = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    categoryArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < jsonArray2.count; i++)
    {
        NSString *cID = [[jsonArray2 objectAtIndex:i] objectForKey:@"categoryID"];
        NSString *cDesc = [[jsonArray2 objectAtIndex:i] objectForKey:@"categoryDesc"];
        NSString *cName = [[jsonArray2 objectAtIndex:i] objectForKey:@"categoryName"];
        
        [categoryArray addObject:[[Categories alloc]initWidthCategoryDesc:cDesc andcategoryName:cName andcategoryID:cID]];
    }
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"catToTopic"]) {
        TopicViewController *tVC = (TopicViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        tVC.theData = [jsonArray2 objectAtIndex:indexPath.row];
        tVC.subURL = [@"http://tandemenvoy.michaeldvinci.com/forum/repliesJSON.php?rID=" stringByAppendingString:[tVC.theData objectForKey:@"categoryID"]];
        
        NSLog(@"output: %@", tVC.subURL);
    }
    
    if ([segue.identifier isEqualToString:@"goBack"]) {
            
        UINavigationController *navigationController = segue.destinationViewController;
        AddPostViewController2 *playerDetailsViewController = [navigationController viewControllers][0];
        playerDetailsViewController.delegate = self;
    }
}

#pragma mark - addPostViewController2Delegate

- (void)addPostViewController2DidCancel:(AddPostViewController2 *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addPostViewController2DidSave:(AddPostViewController2 *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
