//
//  FindLocationViewController.h
//  irsi
//
//  Created by Ben Taylor on 16/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interactions.h"
#import <CoreLocation/CoreLocation.h>
#import "Nationalities.h"
#import "Interactions.h"
#import "EventLog.h"

@interface FindLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *buttonBackTop;

@property (strong, nonatomic) IBOutlet UILabel *labelTopTitle;

@property (strong, nonatomic) IBOutlet UILabel *labelLatTitle;

@property (strong, nonatomic) IBOutlet UILabel *labelLongTitle;

@property (strong, nonatomic) IBOutlet UILabel *labelAddressTitle;

@property (strong, nonatomic) IBOutlet UILabel *labelLatitude;

@property (strong, nonatomic) IBOutlet UILabel *labelLongitude;

@property (strong, nonatomic) IBOutlet UILabel *labelAddress;

@property (strong, nonatomic) IBOutlet UIButton *buttonCalculate;

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

@end
