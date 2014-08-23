//
//  TeamViewController.h
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Nationalities.h"
#import "EventLog.h"

@interface TeamViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UILabel *labelExplanation;

@property (strong, nonatomic) IBOutlet UIButton *buttonODP;

@property (strong, nonatomic) IBOutlet UIButton *buttonAnaes1;

@property (strong, nonatomic) IBOutlet UIButton *buttonCricoid;

@property (strong, nonatomic) IBOutlet UIButton *buttonCSpine;

@property (strong, nonatomic) IBOutlet UIButton *buttonDrugs;

@property (strong, nonatomic) IBOutlet UIButton *buttonScribe;

@property (strong, nonatomic) IBOutlet UIButton *buttonAnaes2;

@property (strong, nonatomic) IBOutlet UIButton *buttonTeamLeader;

@end
