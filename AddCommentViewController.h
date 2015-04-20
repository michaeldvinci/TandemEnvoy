//
//  AddCommentViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/7/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddCommentViewController;

/*!
 *	Sets up the didSave and didCancel methods, allowing for return to previous View Controller
 *  when finished with the current one.
 */
@protocol AddCommentViewControllerDelegate <NSObject>
- (void)addCommentViewControllerDidSave:(AddCommentViewController *)controller;
- (void)addCommentViewControllerDidCancel:(AddCommentViewController *)controller;

@end

@interface AddCommentViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (strong, nonatomic) IBOutlet UITextView *commentView;
@property (strong, nonatomic) NSString *postString;
@property (strong, nonatomic) NSString *topicID;

@property (nonatomic, strong) id <AddCommentViewControllerDelegate> delegate;

/*!
 *	Returns user to previous view
 *
 *	@param sender Sender is user
 */
- (IBAction)cancel:(id)sender;

/*!
 *	Returns user to previous view
 *
 *	@param sender Sender is user
 */
- (IBAction)done:(id)sender;

/*!
 *	pulls data and sends it to the DB using the correct .php file
 *
 *	@param sender Sender is user
 */
- (IBAction)submitData:(id)sender;


@end
