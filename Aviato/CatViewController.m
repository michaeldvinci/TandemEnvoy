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
    self.navigationController.navigationBar.hidden = NO;
    
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
    Categories *catObject;
    catObject = [categoryArray objectAtIndex:[indexPath row]];
    
    catCell.textLabel.text = catObject.categoryName;
    
    catCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    static NSString *cellIdentifier = @"Cell";
    
    /**
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"check.png"]];
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"clock.png"]];
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"cross.png"]];
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"list.png"]];
        
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                 title:@"More"];
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@"Delete"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:_tableView // For row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
    }
     **/
    
    return catCell;
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
    NSURL *url = [NSURL URLWithString:getDataURL];
    NSMutableData *responseData1 = [NSMutableData dataWithContentsOfURL:url];
    
    NSError *error;
    jsonArray2 = [NSJSONSerialization JSONObjectWithData:responseData1 options:kNilOptions error:nil];
    
    categoryArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < jsonArray2.count; i++)
    {
        NSString *cID   = [[jsonArray2 objectAtIndex:i] objectForKey:@"categoryID"];
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
        
        rVC.theData2  = [jsonArray2 objectAtIndex:[indexPath row]];
        rVC.subURL2   = [@"http://tandemenvoy.michaeldvinci.com/forum/topicsJSON.php?tID=" stringByAppendingString:[rVC.theData2 objectForKey:@"categoryID"]];
        rVC.descText2 = [NSString stringWithFormat:@"%@", [rVC.theData2 objectForKey:@"categoryDesc"]];
        rVC.tID = [rVC.theData2 objectForKey:@"categoryID"];
        
        NSLog(@"output: %@", rVC.subURL2);
    }
    
    
    if ([segue.identifier isEqualToString:@"goBack"]) {
        
        UINavigationController *navigationController  = segue.destinationViewController;
        AddPostViewController2 *addPostViewController = [navigationController viewControllers][0];
        addPostViewController.delegate                = self;
        addPostViewController.postString              = @"http://http://tandemenvoy.michaeldvinci.com/forum/addAPost.php?categoryName=%@&categoryDesc=%@";
    }
}


@end
