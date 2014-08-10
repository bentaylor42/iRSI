//
//  DrugsTableViewController.h
//  irsi
//
//  Created by Ben Taylor on 27/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugDoses.h"
#import "Nationalities.h"
#import "DrugLog.h"
#import "InductionAgents.h"
#import "Interactions.h"
#import "EventLog.h"
#import "Patient.h"

@interface DrugsTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
