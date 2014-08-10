//
//  EventLog.m
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "EventLog.h"

@implementation EventLog

@synthesize preO2Start;
@synthesize preO2End;
@synthesize preO2Running;
@synthesize totalPreO2;
@synthesize indicationComplete;
@synthesize drugsComplete;
@synthesize equipComplete;
@synthesize teamComplete;
@synthesize finalComplete;
@synthesize preHospital;

@synthesize indicationChecklist;
@synthesize indicationTicked;
@synthesize indicationPHEM;

@synthesize equipmentTicked;

+(id) sharedPreO2Start
{
    static EventLog * sharedPreO2Start = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPreO2Start = [[self alloc] init];});
    return sharedPreO2Start;
}

+(id) sharedPreO2End
{
    static EventLog * sharedPreO2End = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPreO2End = [[self alloc] init];});
    return sharedPreO2End;
}

+(id) sharedPreO2Running
{
    static EventLog * sharedPreO2Running = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPreO2Running = [[self alloc] init];});
    return sharedPreO2Running;
}

+(id) sharedTotalPreO2
{
    static EventLog * sharedTotalPreO2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedTotalPreO2 = [[self alloc] init];});
    return sharedTotalPreO2;
}

+(id) sharedIndicationComplete
{
    static EventLog * sharedIndicationComplete = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIndicationComplete = [[self alloc] init];});
    return sharedIndicationComplete;
}

+(id) sharedDrugsComplete
{
    static EventLog * sharedDrugsComplete = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDrugsComplete = [[self alloc] init];});
    return sharedDrugsComplete;
}

+(id) sharedEquipComplete;
{
    static EventLog * sharedEquipComplete = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedEquipComplete = [[self alloc] init];});
    return sharedEquipComplete;
}

+(id) sharedTeamComplete
{
    static EventLog * sharedTeamComplete = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedTeamComplete = [[self alloc] init];});
    return sharedTeamComplete;
}

+(id) sharedFinalComplete
{
    static EventLog * sharedFinalComplete = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedFinalComplete = [[self alloc] init];});
    return sharedFinalComplete;
}

+(id) sharedPreHospital
{
    static EventLog * sharedPreHospital = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPreHospital = [[self alloc] init];});
    return sharedPreHospital;
}

+(id) sharedIndicationChecklist
{
    static EventLog * sharedIndicationChecklist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIndicationChecklist = [[self alloc] init];});
    return sharedIndicationChecklist;
}

+(id) sharedIndicationTicked
{
    static EventLog * sharedIndicationTicked = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIndicationTicked = [[self alloc] init];});
    return sharedIndicationTicked;
}

+(id) sharedIndicationPHEM
{
    static EventLog * sharedIndicationPHEM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIndicationPHEM = [[self alloc] init];});
    return sharedIndicationPHEM;
}

+(id) sharedEquipmentTicked
{
    static EventLog * sharedIndicationPHEM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIndicationPHEM = [[self alloc] init];});
    return sharedIndicationPHEM;
}

- (id) init
{
    if (self = [super init])
    {
        preO2Start = [[NSNumber alloc] init];
        preO2End = [[NSNumber alloc] init];
        preO2Running = [[NSNumber alloc] initWithBool:NO];
        totalPreO2 = [[NSNumber alloc] init];
        indicationComplete = [[NSNumber alloc] initWithInteger:0];
        drugsComplete = [[NSNumber alloc] initWithInteger:0];
        equipComplete = [[NSNumber alloc] initWithInteger:0];
        teamComplete = [[NSNumber alloc] initWithInteger:0];
        finalComplete = [[NSNumber alloc] initWithInteger:0];
        preHospital = [[NSNumber alloc] initWithBool:NO];
        
        indicationChecklist = [[NSArray alloc] init];
        indicationTicked = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil];
        indicationPHEM = [[NSArray alloc] init];
        
        equipmentTicked = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
        
    }
    return self;
}

- (void) dealloc {};

@end
