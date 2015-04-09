//
//  AddCommentViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/7/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddCommentViewController;

@protocol AddCommentViewControllerDelegate <NSObject>
- (void)addCommentViewControllerDidSave:(AddCommentViewController *)controller;
- (void)addCommentViewControllerDidCancel:(AddCommentViewController *)controller;

@end

@interface AddCommentViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet UITextView *commentView;
@property (strong, nonatomic) NSString *postString;
@property (strong, nonatomic) NSString *tID;

@property(nonatomic, weak) id <AddCommentViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)submitData:(id)sender;

@end
