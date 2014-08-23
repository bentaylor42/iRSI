//
//  ToolsViewController.h
//  irsi
//
//  Created by Ben Taylor on 15/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Nationalities.h"
#import "Interactions.h"

@interface ToolsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UIButton *buttonRocClock;

@property (strong, nonatomic) IBOutlet UIButton *buttonPaedsCalc;

@property (strong, nonatomic) IBOutlet UIButton *buttonHeightWeight;

@property (strong, nonatomic) IBOutlet UIButton *buttonVentCalc;

@property (strong, nonatomic) IBOutlet UIButton *buttonGPS;

@end
