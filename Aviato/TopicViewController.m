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
#import "AddCommentViewController.h"

#define getDataURL @"http://tandemenvoy.michaeldvinci.com/forum/repliesJSON.php?rID="

@interface TopicViewController ()

@end

@implementation TopicViewController

@synthesize jsonArray3, topicArray, tableView, theData, refreshControl, subURL, textView, descText, user, topID;

- (void)viewDidLoad {
	[super viewDidLoad];

	user = [User getInstance];

	self.title = @"Commentary";
	textView.text = descText;

	[self retrieveData];

	UITableViewController *tvController = [[UITableViewController alloc] init];
	tvController.tableView = self.tableView;

	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(updateTable:) forControlEvents:UIControlEventValueChanged];
	tvController.refreshControl = self.refreshControl;

	NSLog(@"topID: %@", topID);
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
	return topicArray.count;
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
	static NSString *CellIdentifier = @"topCell";
	UITableViewCell *topCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

	// Configure the cell...
	Posts *topObject;
	topObject = [topicArray objectAtIndex:[indexPath row]];

	topCell.textLabel.text = topObject.replyContent;
	topCell.detailTextLabel.text = topObject.replyUser;
	topCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return topCell;
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
	[self retrieveData];
	[self.tableView reloadData];

	[refreshControl endRefreshing];
}

/*!
 *	allows the user to cancel back to the previous view
 *
 *	@param controller controller object
 */
- (void)addCommentViewControllerDidCancel:(AddCommentViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}

/*!
 *	allows the user to cancel back to the previous view
 *
 *	@param controller controller object
 */
- (void)addCommentViewControllerDidSave:(AddCommentViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Class Methods
/*!
 *	when called, it sub queries the proper .php file and popultes the JSON data into useful data
 */
- (void)retrieveData;
{
	NSURL *url = [NSURL URLWithString:subURL];
	NSData *data = [NSData dataWithContentsOfURL:url];

	jsonArray3 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

	topicArray = [[NSMutableArray alloc] init];

	for (int i = 0; i < jsonArray3.count; i++) {
		NSString *rTopic = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyTopic"];
		NSString *rID = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyID"];
		NSString *rDate = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyDate"];
		NSString *rContent = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyContent"];
		NSString *rBy = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyBy"];
		NSString *rUser = [[jsonArray3 objectAtIndex:i] objectForKey:@"replyUser"];

		[topicArray addObject:[[Posts alloc]initWidthReplyBy:rBy andreplyDate:rDate andreplyTopic:rTopic andreplyContent:rContent andreplyID:rID andreplyUser:rUser]];
	}
	[self.tableView reloadData];
}

/*!
 *	sets variables based on which segue is being called
 *
 *	@param segue  depends on which segue is being called
 *	@param sender Sender is User
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"startConvo"]) {
		UINavigationController *navigationController  = segue.destinationViewController;
		AddCommentViewController *aCVC                = [navigationController viewControllers][0];
		aCVC.delegate                                 = self;
		aCVC.topicID                                  = topID;
		NSLog(@"topID: %@", topID);
	}
}

@end
