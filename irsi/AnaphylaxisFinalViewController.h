//
//  AnaphylaxisFinalViewController.h
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Interactions.h"

@interface AnaphylaxisFinalViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelPiraton;

@property (strong, nonatomic) IBOutlet UILabel *labelHydrocort;

@property (strong, nonatomic) IBOutlet UIView *buttonFinished;
- (IBAction)buttonFinished:(id)sender;


@end
