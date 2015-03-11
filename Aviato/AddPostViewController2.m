//
//  AddPostViewController2.m
//  Aviato
//
//  Created by Michael Vinci on 3/10/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "AddPostViewController2.h"

@interface AddPostViewController2 () <AddPostViewController2Delegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation AddPostViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self.delegate addPostViewController2DidCancel:self];
}
- (IBAction)done:(id)sender
{
    [self.delegate addPostViewController2DidSave:self];
}

- (void)touchesBegan: (NSSet *) touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([_textField isFirstResponder] && [touch view] != _textField) {
        [_textField resignFirstResponder];
    }
         [super touchesBegan: touches withEvent:event];
}

@end
