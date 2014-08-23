//
//  Alerts.h
//  irsi
//
//  Created by Ben Taylor on 15/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alerts : NSObject{
    NSNumber *preO2AlertOn;
    NSNumber *rocClockAlertOn;
    NSNumber *intubationAlertOn;
    
    NSNumber *intubationStartTime;
    NSNumber *intubationTimerRunning;
    NSNumber *intubationTotalTime;
    
    NSNumber * preO2Alert1;
    NSNumber * preO2Alert2;
    NSNumber * rocAlert1;
    NSNumber * rocAlert2;
}

@property (nonatomic, retain) NSNumber *preO2AlertOn;
@property (nonatomic, retain) NSNumber *rocClockAlertOn;
@property (nonatomic, retain) NSNumber *intubationAlertOn;

@property (nonatomic, retain) NSNumber *intubationStartTime;
@property (nonatomic, retain) NSNumber *intubationTimerRunning;
@property (nonatomic, retain) NSNumber *intubationTotalTime;

@property (nonatomic, retain) NSNumber * preO2Alert1;
@property (nonatomic, retain) NSNumber * preO2Alert2;
@property (nonatomic, retain) NSNumber * rocAlert1;
@property (nonatomic, retain) NSNumber * rocAlert2;

+ (id) sharedPreO2AlertOn;
+ (id) sharedRocClockAlertOn;
+ (id) sharedIntubationAlertOn;
+ (id) sharedIntubationStartTime;
+ (id) sharedIntubationTimerRunning;
+ (id) sharedIntubationTotalTime;
+ (id) sharedPreO2Alert1;
+ (id) sharedPreO2Alert2;
+ (id) sharedRocAlert1;
+ (id) sharedRocAlert2;

@end
