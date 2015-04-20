//
//  PandaFinderViewController.m
//  Aviato
//
//  Created by Michael Vinci on 4/17/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "PandaFinderViewController.h"

@interface PandaFinderViewController () <MKMapViewDelegate>

@end

@implementation PandaFinderViewController {
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)mapMap:(MKMapView *)mapMap didUpdateUserLocation:(MKUserLocation *)userLocation {
	self.initialLocation = userLocation.location;

	MKCoordinateRegion region;
	region.center = mapMap.userLocation.coordinate;
	region.span = MKCoordinateSpanMake(.1, .1);

	region = [mapMap regionThatFits:region];
	[mapMap setRegion:region animated:YES];
}

@end
