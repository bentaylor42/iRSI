//
//  EquipmentChecklistViewController.h
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Interactions.h"
#import "EventLog.h"
#import "Nationalities.h"

@interface EquipmentChecklistViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *labelDisplayVT;

@property (strong, nonatomic) IBOutlet UILabel *labelIBWCalced;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *viewEquipment;
@end
