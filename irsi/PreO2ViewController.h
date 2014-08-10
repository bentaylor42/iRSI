//
//  PreO2ViewController.h
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventLog.h"
#import <QuartzCore/QuartzCore.h>
#import "Nationalities.h"

@interface PreO2ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelPreO2Time;

@property (strong, nonatomic) IBOutlet UIImageView *imageBorder;

@property (strong, nonatomic) IBOutlet UIButton *buttonStopPreO2;

@property (strong, nonatomic) IBOutlet UIButton *buttonStartPreO2;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UILabel *labelColour;

@end
