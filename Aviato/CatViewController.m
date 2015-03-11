//
//  CatViewController.m
//  Aviato
//
//  Created by Michael Vinci on 3/11/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "CatViewController.h"
#import "Categories.h"

#define getDataURL @"http://tandemenvoy.michaeldvinci.com/forum/categoriesJSON.php"

@interface CatViewController ()

@end

@implementation CatViewController

@synthesize jsonArray2, categoryArray, tableView, refreshControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Test replies";
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
    
    NSLog(@"%@", url);
    NSLog(@"%@", data);
    
    jsonArray2 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //setting up replies array
    
    categoryArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < jsonArray2.count; i++)
    {
        NSString * cID = [[jsonArray2 objectAtIndex:i] objectForKey:@"categoryID"];
        NSString * cDesc = [[jsonArray2 objectAtIndex:i] objectForKey:@"categoryDesc"];
        NSString * cName = [[jsonArray2 objectAtIndex:i] objectForKey:@"categoryName"];
        
        [categoryArray addObject:[[Categories alloc]initWidthCategoryDesc:cDesc andcategoryName:cName andcategoryID:cID]];
    }
    
    [self->tableView reloadData];
}

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

@end
