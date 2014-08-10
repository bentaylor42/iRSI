//
//  DrugsViewController.h
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugDoses.h"
#import "DrugLog.h"
#import "Interactions.h"
#import "Nationalities.h"
#import "InductionAgents.h"

@interface DrugsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedDoseDisplayType;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *viewDrugsTable;

@property (strong, nonatomic) IBOutlet UIView *viewDrugSelector;

@property (strong, nonatomic) IBOutlet UITableView *tableDrugSelector;

- (IBAction)buttonClose:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollSelector;

@property (strong, nonatomic) IBOutlet UIView *viewSelector;

@property (strong, nonatomic) IBOutlet UILabel *labelTapToSelect;

@end

