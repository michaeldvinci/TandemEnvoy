//
//  AddReplyViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/6/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddReplyViewController;

/*!
 *	Sets up the didSave and didCancel methods, allowing for return to previous View Controller
 *  when finished with the current one.
 */
@protocol AddReplyViewControllerDelegate <NSObject>
- (void)addReplyViewControllerDidSave:(AddReplyViewController *)controller;
- (void)addReplyViewControllerDidCancel:(AddReplyViewController *)controller;

@end

@interface AddReplyViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (strong, nonatomic) IBOutlet UITextField *topicSubject;
@property (strong, nonatomic) NSString *topicCat;
@property (strong, nonatomic) NSString *topicBy;
@property (strong, nonatomic) NSString *postString;


@property(nonatomic, strong) id <AddReplyViewControllerDelegate> delegate;

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