//
//  AddReplyViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/6/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddReplyViewController;

@protocol AddReplyViewControllerDelegate <NSObject>
- (void)addReplyViewControllerDidSave:(AddReplyViewController *)controller;
- (void)addReplyViewControllerDidCancel:(AddReplyViewController *)controller;

@end

@interface AddReplyViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet UITextField *topicSubject;
@property (weak, nonatomic) NSString *topicCat;
@property (weak, nonatomic) NSString *topicBy;
@property (strong, nonatomic) NSString *postString;


@property(nonatomic, weak) id <AddReplyViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)submitData:(id)sender;

@end