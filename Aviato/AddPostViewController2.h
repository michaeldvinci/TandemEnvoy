//
//  AddPostViewController2.h
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddPostViewController2;

/*!
 *	Sets up the didSave and didCancel methods, allowing for return to previous View Controller
 *  when finished with the current one.
 */
@protocol AddPostViewController2Delegate <NSObject>
- (void)addPostViewController2DidSave:(AddPostViewController2 *)controller;
- (void)addPostViewController2DidCancel:(AddPostViewController2 *)controller;

@end

@interface AddPostViewController2 : UITableViewController <UIAlertViewDelegate> {
    
}

@property (nonatomic, strong) User *user;
@property (strong, nonatomic) IBOutlet UITextField *categoryName;
@property (strong, nonatomic) IBOutlet UITextField *endTime;
@property (strong, nonatomic) IBOutlet UITextView *categoryDesc;
@property (strong, nonatomic) NSString *postString;


@property (nonatomic, strong) id <AddPostViewController2Delegate> delegate;

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
