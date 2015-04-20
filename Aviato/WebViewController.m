//
//  WebViewController.m
//  Aviato
//
//  Created by Michael Vinci on 4/19/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "WebViewController.h"
#import <UIKit/UIWebView.h>

@interface WebViewController ()

@end

@implementation WebViewController {
}

- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *strURL = @"http://www.webn.es";
	NSURL *url = [NSURL URLWithString:strURL];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[self.myWebView loadRequest:urlRequest];
}

@end
