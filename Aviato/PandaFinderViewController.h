//
//  PandaFinderViewController.h
//  Aviato
//
//  Created by Michael Vinci on 4/17/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PandaFinderViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapMap;
@property (nonatomic, retain) CLLocation* initialLocation;

@end
