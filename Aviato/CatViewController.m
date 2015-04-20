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

/*!
 *	returns the number of rows to populate the UITableView
 *
 *	@param tableView UITableView to populate
 *	@param section   response from .php sub querey
 *
 *	@return returns integer for number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categoryArray.count; 
}

/*!
 *	populates individual rows with the specific object from the parsed JSON data
 *
 *	@param myTableView specific tableview being populated
 *	@param indexPath   specific row being populated
 *
 *	@return cell information being returned to uitableviewrow
 */
- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"catCell";
    UITableViewCell *catCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Categories *catObject;
    catObject = [categoryArray objectAtIndex:[indexPath row]];
    
    catCell.textLabel.text = catObject.categoryName;
    catCell.detailTextLabel.text = catObject.categoryUser;
    
    catCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    static NSString *cellIdentifier = @"Cell";
    
    return catCell;
}

/*!
 *	allows for the specific row to be selected for the proper segue
 *
 *	@param myTableView specific tableview being populated
 *	@param indexPath   specific row being populated
 */
- (void)tableView:(UITableView *)myTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*!
 *	allows for pull-to-refresh to be implemented
 *
 *	@param rControl refreshcontrol variable
 */
- (void)updateTable:(UIRefreshControl *)rControl
{
    [self retrieveData];
    [self.tableView reloadData];

    [refreshControl endRefreshing];
}

#pragma mark -
#pragma mark Class Methods

/*!
 *	when called, it sub queries the proper .php file and popultes the JSON data into useful data
 */
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
        NSString *cUser = [[jsonArray2 objectAtIndex:i] objectForKey:@"categoryUser"];

        [categoryArray addObject:[[Categories alloc]initWidthCategoryDesc:cDesc andcategoryName:cName andcategoryID:cID andcategoryUser: (NSString *)cUser]];
    }
    
    [self.tableView reloadData];
}

#pragma mark - addPostViewController2Delegate

/*!
 *	allows the user to cancel back to the previous view
 *
 *	@param controller controller object
 */
- (void)addPostViewController2DidCancel:(AddPostViewController2 *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*!
 *	allows the user to cancel back to the previous view
 *
 *	@param controller controller objecet
 */
- (void)addPostViewController2DidSave:(AddPostViewController2 *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*!
 *
 *	sets variables based on which segue is being called, catToRepo -or- goBack
 *
 *  catToRepo will pull the correct data and then populate the next view based on that data
 *  goBack will allow the transition to the 'add a post' view
 *
 *
 *	@param segue  depends on which segue is being called
 *	@param sender sender is user
 */
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
