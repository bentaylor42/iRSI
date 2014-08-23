//
//  EmergencyMenuViewController.h
//  irsi
//
//  Created by Ben Taylor on 15/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Nationalities.h"
#import "Interactions.h"

@interface EmergencyMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *buttonFailedIntubation;

@property (strong, nonatomic) IBOutlet UIButton *buttonAnaphylaxis;

@property (strong, nonatomic) IBOutlet UIButton *buttonALS;

@property (strong, nonatomic) IBOutlet UIButton *buttonAPLS;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

- (IBAction)buttonBack:(id)sender;

@end
