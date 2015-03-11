//
//  AddPostViewController2.h
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddPostViewController2;

@protocol AddPostViewController2Delegate <NSObject>
- (void)addPostViewController2DidCancel:(AddPostViewController2 *)controller;
- (void)addPostViewController2DidSave:(AddPostViewController2 *)controller;
@end

@interface AddPostViewController2 : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *addCat;

@property(nonatomic, weak) id <AddPostViewController2Delegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
