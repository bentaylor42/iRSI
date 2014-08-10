//
//  DefaultsViewController.h
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventLog.h"
#import "Patient.h"

@interface DefaultsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISwitch * switchPHEM;

@property (strong, nonatomic) IBOutlet UISegmentedControl * segmentedHeight;

@property (strong, nonatomic) IBOutlet UISegmentedControl * segmentedWeight;

@property (strong, nonatomic) IBOutlet UISegmentedControl * segmentedDrugDoseDisplayType;

@end
