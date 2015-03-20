//
//  CatViewController.m
//  Aviato
//
//  Created by Michael Vinci on 3/11/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "Categories.h"
#import "CatViewController.h"
#import "TopicViewController.h"
#import "RepoViewController.h"

#define getDataURL @"http://tandemenvoy.michaeldvinci.com/forum/categoriesJSON.php"

@interface CatViewController()

@end

@implementation CatViewController

@synthesize jsonArray2, categoryArray, tableView, refreshControl, user;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Recent Posts";
    self.navigationItem.hidesBackButton = YES;
    
    user = [User getInstance];
    
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
    catObject = [categoryArray objectAtIndex:[indexPath row]] ;
    
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
    NSMutableData *responseData1 = [NSMutableData dataWithContentsOfURL:url];
    
    NSError *error;
    jsonArray2 = [NSJSONSerialization JSONObjectWithData:responseData1 options:kNilOptions error:nil];
    
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

#pragma mark - addPostViewController2Delegate

- (void)addPostViewController2DidCancel:(AddPostViewController2 *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addPostViewController2DidSave:(AddPostViewController2 *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"catToRepo"]) {
        RepoViewController *rVC = (RepoViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        rVC.theData2 = [jsonArray2 objectAtIndex:[indexPath row]];
        rVC.subURL2 = [@"http://tandemenvoy.michaeldvinci.com/forum/topicsJSON.php?tID=" stringByAppendingString:[rVC.theData2 objectForKey:@"categoryID"]];
        rVC.descText2 = [NSString stringWithFormat:@"%@", [rVC.theData2 objectForKey:@"categoryDesc"]];
        
        NSLog(@"output: %@", rVC.subURL2);
    }
    
    
    if ([segue.identifier isEqualToString:@"goBack"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        AddPostViewController2 *addPostViewController = [navigationController viewControllers][0];
        addPostViewController.delegate = self;
    }
}


@end
