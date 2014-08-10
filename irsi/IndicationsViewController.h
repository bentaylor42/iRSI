//
//  IndicationsViewController.h
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventLog.h"
#import "Interactions.h"

@interface IndicationsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *viewAirway;

@property (strong, nonatomic) IBOutlet UIView *viewNODESAT;

@end
