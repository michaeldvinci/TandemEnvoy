//
//  RepoViewController.m
//  Aviato
//
//  Created by Michael Vinci on 3/14/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "User.h"
#import "Topic.h"
#import "RepoViewController.h"
#import "TopicViewController.h"
#import "CatViewController.h"
#import "AddCommentViewController.h"

@interface RepoViewController ()

@end

@implementation RepoViewController

@synthesize repoJsonArray, user, repoArray, tableView, repoViewController, refreshControl, repoTF, descText2, subURL2, theData2, tID;

- (void)viewDidLoad {
	[super viewDidLoad];

	user = [User getInstance];

	self.title = @"Replies to job";
	repoTF.text = descText2;

	[self retrieveData];

	UITableViewController *tvController = [[UITableViewController alloc] init];
	tvController.tableView = self.tableView;

	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(updateTable:) forControlEvents:UIControlEventValueChanged];
	tvController.refreshControl = self.refreshControl;

	AddCommentViewController *aCVC;

	aCVC.topicID = tID;
}

- (void) viewDidAppear {
    [self updateDB];
    [tableView reloadData];
}

/*!
 *	returns the number of rows to populate the UITableView
 *
 *	@param tableView UITableView to populate
 *	@param section   response from .php sub querey
 *
 *	@return returns integer for number of rows
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return repoArray.count;
}

/*!
 *	populates individual rows with the specific object from the parsed JSON data
 *
 *	@param myTableView specific tableview being populated
 *	@param indexPath   specific row being populated
 *
 *	@return cell information being returned to uitableviewrow
 */
- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"repoCell";
	UITableViewCell *repoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

	// Configure the cell...
	Topic *repoObject;
	repoObject = [repoArray objectAtIndex:[indexPath row]];

	repoCell.textLabel.text = repoObject.topicSubject;
	repoCell.detailTextLabel.text = repoObject.topicUser;
	repoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return repoCell;
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

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

/*!
 *	allows for pull-to-refresh to be implemented
 *
 *	@param rControl refreshcontrol variable
 */
- (void)updateTable:(UIRefreshControl *)rControl {
    [self updateDB];
	[self retrieveData];
	[self.tableView reloadData];

	[refreshControl endRefreshing];
}

#pragma mark - addPostViewController2Delegate

/*!
 *	allows the user to cancel back to the previous view
 *
 *	@param controller controller object
 */
- (void)addReplyViewControllerDidCancel:(AddReplyViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}

/*!
 *	allows the user to cancel back to the previous view
 *
 *	@param controller controller object
 */
- (void)addReplyViewControllerDidSave:(AddReplyViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Class Methods

/*!
 *	when called, it sub queries the proper .php file and popultes the JSON data into useful data
 */
- (void)retrieveData;
{
    [self updateDB];
    
	NSURL *url = [NSURL URLWithString:subURL2];
	NSData *data = [NSData dataWithContentsOfURL:url];

	repoJsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

	repoArray = [[NSMutableArray alloc] init];

	for (int i = 0; i < repoJsonArray.count; i++) {
		NSString *reID = [[repoJsonArray objectAtIndex:i] objectForKey:@"topicID"];
		NSString *reCat = [[repoJsonArray objectAtIndex:i] objectForKey:@"topicCat"];
		NSString *reDate = [[repoJsonArray objectAtIndex:i] objectForKey:@"topicDate"];
		NSString *reBy = [[repoJsonArray objectAtIndex:i] objectForKey:@"topicBy"];
		NSString *reSubject = [[repoJsonArray objectAtIndex:i] objectForKey:@"topicSubject"];
		NSString *reUser = [[repoJsonArray objectAtIndex:i] objectForKey:@"topicUser"];

		[repoArray addObject:[[Topic alloc]initWidthTopicID:reID andtopicCat:reCat andtopicDate:reDate andtopicBy:reBy andtopicSubject:reSubject andtopicUser:reUser]];
	}
	[self.tableView reloadData];
}

- (void)updateDB {
    //[self updateDB];
    
    NSString *myRequestString = [NSString stringWithFormat:@""];
    NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tandemenvoy.michaeldvinci.com/forum/updateDB.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:myRequestData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:1];
    NSLog(@"%@", response);
}

/*!
 *	sets variables based on which segue is being called
 *
 *	@param segue  depends on which segue is being called
 *	@param sender Sender is User
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"topicToReply"]) {
		TopicViewController *tVC = (TopicViewController *)[segue destinationViewController];
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

		tVC.theData = [repoJsonArray objectAtIndex:[indexPath row]];
        tVC.subURL = [NSString stringWithFormat:@"http://tandemenvoy.michaeldvinci.com/forum/repliesJSON.php?rTopic=%@&rID=%@",[tVC.theData objectForKey:@"topicID"], [[User getInstance] userID]];
		tVC.descText = [NSString stringWithFormat:@"%@", [tVC.theData objectForKey:@"categoryDesc"]];

		NSLog(@"output: %@", tVC.subURL);

		tVC.topID = [tVC.theData objectForKey:@"topicID"];
        tVC.catID = tID;
	}

	if ([segue.identifier isEqualToString:@"makeOffer"]) {
		UINavigationController *navigationController  = segue.destinationViewController;
		AddReplyViewController *rVC                   = [navigationController viewControllers][0];
		rVC.delegate                                  = self;
		rVC.topicCat                                  = tID;
	}
}

@end
