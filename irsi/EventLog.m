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
@synthesize teamTicked;
@synthesize finalTicked;
@synthesize finalChecklist;
@synthesize finalCricoid;
@synthesize equipmentTicked;
@synthesize rocEnd;
@synthesize rocRunning;
@synthesize rocStart;
@synthesize totalRoc;
@synthesize intubationAttemptRunning;
@synthesize intubationAttemptStart;
@synthesize confirmationChecklist;
@synthesize confirmationPHEM;
@synthesize confirmationTicked;
@synthesize latRSI;
@synthesize longRSI;
@synthesize clGrade;
@synthesize successfulTubeTime;
@synthesize jobAddress;
@synthesize gpsFix;
@synthesize drugsGiven;
@synthesize intubationStarted;
@synthesize intubationSuccessful;

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

+(id) sharedTeamTicked
{
    static EventLog * sharedTeamTicked = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedTeamTicked = [[self alloc] init];});
    return sharedTeamTicked;
}

+(id) sharedFinalTicked
{
    static EventLog * sharedFinalTicked = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedFinalTicked = [[self alloc] init];});
    return sharedFinalTicked;
}

+(id) sharedFinalChecklist
{
    static EventLog * sharedFinalChecklist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedFinalChecklist = [[self alloc] init];});
    return sharedFinalChecklist;
}

+(id) sharedFinalCricoid
{
    static EventLog * sharedFinalCricoid = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedFinalCricoid = [[self alloc] init];});
    return sharedFinalCricoid;
}

+(id) sharedRocEnd
{
    static EventLog * sharedRocEnd = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRocEnd = [[self alloc] init];});
    return sharedRocEnd;
}

+(id) sharedRocRunning
{
    static EventLog * sharedRocRunning = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRocRunning = [[self alloc] init];});
    return sharedRocRunning;
}

+(id) sharedRocStart
{
    static EventLog * sharedRocStart = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRocStart = [[self alloc] init];});
    return sharedRocStart;
}

+(id) sharedtotalRoc
{
    static EventLog * sharedtotalRoc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedtotalRoc = [[self alloc] init];});
    return sharedtotalRoc;
}

+(id) sharedIntubationAttemptStart
{
    static EventLog * sharedIntubationAttemptStart = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIntubationAttemptStart = [[self alloc] init];});
    return sharedIntubationAttemptStart;
}

+(id) sharedIntubationAttemptRunning
{
    static EventLog * sharedIntubationAttemptRunning = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIntubationAttemptRunning = [[self alloc] init];});
    return sharedIntubationAttemptRunning;
}

+(id) sharedConfirmationChecklist;
{
    static EventLog * sharedConfirmationChecklist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedConfirmationChecklist = [[self alloc] init];});
    return sharedConfirmationChecklist;
}

+(id) sharedConfirmationPHEM;
{
    static EventLog * sharedConfirmationPHEM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedConfirmationPHEM = [[self alloc] init];});
    return sharedConfirmationPHEM;
}

+(id) sharedConfirmationTicked;
{
    static EventLog * sharedConfirmationTicked = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedConfirmationTicked = [[self alloc] init];});
    return sharedConfirmationTicked;
}

+(id) sharedLatRSI;
{
    static EventLog * sharedLatRSI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedLatRSI = [[self alloc] init];});
    return sharedLatRSI;
}

+(id) sharedLongRSI;
{
    static EventLog * sharedLongRSI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedLongRSI = [[self alloc] init];});
    return sharedLongRSI;
}

+(id) sharedCLGrade;
{
    static EventLog * sharedCLGrade = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedCLGrade = [[self alloc] init];});
    return sharedCLGrade;
}

+(id) sharedSuccessfulTubeTime;
{
    static EventLog * sharedSuccessfulTubeTime = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedSuccessfulTubeTime = [[self alloc] init];});
    return sharedSuccessfulTubeTime;
}

+(id) sharedJobAddress;
{
    static EventLog * sharedJobAddress = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedJobAddress = [[self alloc] init];});
    return sharedJobAddress;
}

+(id) sharedGPSFix;
{
    static EventLog * sharedGPSFix = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedGPSFix = [[self alloc] init];});
    return sharedGPSFix;
}

+(id) sharedDrugsGiven;
{
    static EventLog * sharedDrugsGiven = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDrugsGiven = [[self alloc] init];});
    return sharedDrugsGiven;
}

+(id) sharedIntubationSuccessful;
{
    static EventLog * sharedIntubationSuccessful = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIntubationSuccessful = [[self alloc] init];});
    return sharedIntubationSuccessful;
}

+(id) sharedIntubationStarted;
{
    static EventLog * sharedIntubationStarted = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIntubationStarted = [[self alloc] init];});
    return sharedIntubationStarted;
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
        teamTicked = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
        finalTicked = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
        finalChecklist = [[NSMutableArray alloc]init];
        finalCricoid = [[NSArray alloc]init];
        
        equipmentTicked = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
        confirmationChecklist = [[NSMutableArray alloc] init];
        confirmationPHEM = [[NSMutableArray alloc] init];
        confirmationTicked = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
        
        rocStart = [[NSNumber alloc] init];
        rocEnd = [[NSNumber alloc] init];
        rocRunning = [[NSNumber alloc] initWithBool:NO];
        totalRoc = [[NSNumber alloc] init];
        
        intubationAttemptStart = [[NSNumber alloc] init];
        intubationAttemptRunning = [[NSNumber alloc] initWithBool:NO];
        
        latRSI = [[NSNumber alloc] init];
        longRSI = [[NSNumber alloc] init];
        jobAddress = [[NSString alloc] init];
        gpsFix = [[NSNumber alloc] initWithBool:NO];
        
        clGrade = [[NSString alloc] init];
        successfulTubeTime = [[NSNumber alloc] init];
        
        drugsGiven = [[NSDate alloc] init];
        intubationStarted = [[NSDate alloc] init];
        intubationSuccessful = [[NSDate alloc] init];
    }
    return self;
}

- (void) dealloc {};

@end
