//
//  Alerts.m
//  irsi
//
//  Created by Ben Taylor on 15/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "Alerts.h"

@implementation Alerts

@synthesize preO2AlertOn;
@synthesize rocClockAlertOn;
@synthesize intubationAlertOn;
@synthesize intubationStartTime;
@synthesize intubationTimerRunning;
@synthesize intubationTotalTime;
@synthesize preO2Alert1;
@synthesize preO2Alert2;
@synthesize rocAlert1;
@synthesize rocAlert2;

+(id) sharedIntubationAlertOn
{
    static Alerts * sharedIntubationAlertOn = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIntubationAlertOn = [[self alloc] init];});
    return sharedIntubationAlertOn;
}

+(id) sharedIntubationStartTime
{
    static Alerts * sharedIntubationStartTime = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIntubationStartTime = [[self alloc] init];});
    return sharedIntubationStartTime;
}

+(id) sharedIntubationTimerRunning
{
    static Alerts * sharedIntubationTimerRunning = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIntubationTimerRunning = [[self alloc] init];});
    return sharedIntubationTimerRunning;
}

+(id) sharedIntubationTotalTime
{
    static Alerts * sharedIntubationTotalTime = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIntubationTotalTime = [[self alloc] init];});
    return sharedIntubationTotalTime;
}

+(id) sharedPreO2AlertOn
{
    static Alerts * sharedPreO2AlertOn = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPreO2AlertOn = [[self alloc] init];});
    return sharedPreO2AlertOn;
}

+(id) sharedRocClockAlertOn
{
    static Alerts * sharedRocClockAlertOn = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRocClockAlertOn = [[self alloc] init];});
    return sharedRocClockAlertOn;
}

+(id) sharedPreO2Alert1;
{
    static Alerts * sharedPreO2Alert1 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPreO2Alert1 = [[self alloc] init];});
    return sharedPreO2Alert1;
}

+(id) sharedPreO2Alert2
{
    static Alerts * sharedPreO2Alert2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPreO2Alert2 = [[self alloc] init];});
    return sharedPreO2Alert2;
}

+(id) sharedRocAlert1
{
    static Alerts * sharedRocAlert1 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRocAlert1 = [[self alloc] init];});
    return sharedRocAlert1;
}

+(id) sharedRocAlert2
{
    static Alerts * sharedRocAlert2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRocAlert2 = [[self alloc] init];});
    return sharedRocAlert2;
}

- (id) init{
    if (self = [super init]){
        preO2AlertOn = [[NSNumber alloc] initWithBool:NO];
        rocClockAlertOn = [[NSNumber alloc] initWithBool:NO];
        intubationAlertOn = [[NSNumber alloc] initWithBool:NO];
        intubationTimerRunning = [[NSNumber alloc] initWithBool:NO];
        intubationStartTime = [[NSNumber alloc] init];
        intubationTotalTime = [[NSNumber alloc] init];
        preO2Alert2 = [[NSNumber alloc] initWithBool:NO];
        preO2Alert1 = [[NSNumber alloc] initWithBool:NO];
        rocAlert2 = [[NSNumber alloc] initWithBool:NO];
        rocAlert1 = [[NSNumber alloc] initWithBool:NO];
    }
    return self;
}
@end
