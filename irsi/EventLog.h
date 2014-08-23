//
//  EventLog.h
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface EventLog : NSObject

{
    NSNumber *preO2Start;
    NSNumber *preO2End;
    NSNumber *totalPreO2;
    NSNumber *preO2Running;
    
    NSNumber *indicationComplete;
    NSNumber *drugsComplete;
    NSNumber *equipComplete;
    NSNumber *teamComplete;
    NSNumber *finalComplete;
    NSNumber *preHospital;
    
    NSArray *indicationChecklist;
    NSMutableArray *indicationTicked;
    NSArray *indicationPHEM;
    NSMutableArray *teamTicked;
    NSMutableArray *finalTicked;
    NSMutableArray *finalChecklist;
    NSArray *finalCricoid;
    NSMutableArray * equipmentTicked;
    NSMutableArray * confirmationTicked;
    NSMutableArray * confirmationPHEM;
    NSMutableArray * confirmationChecklist;
    
    NSNumber *rocRunning;
    NSNumber *rocStart;
    NSNumber *rocEnd;
    NSNumber *totalRoc;
    
    NSNumber *intubationAttemptStart;
    NSNumber *intubationAttemptRunning;
    
    NSNumber *latRSI;
    NSNumber *longRSI;
    NSString *jobAddress;
    NSNumber *gpsFix;
    
    NSString * clGrade;
    NSNumber * successfulTubeTime;
    
    NSDate * drugsGiven;
    NSDate * intubationStarted;
    NSDate * intubationSuccessful;
}

@property (nonatomic, retain) NSNumber *preO2Start;
@property (nonatomic, retain) NSNumber *preO2End;
@property (nonatomic, retain) NSNumber *totalPreO2;
@property (nonatomic, retain) NSNumber *preO2Running;

@property (nonatomic, retain) NSNumber *indicationComplete;
@property (nonatomic, retain) NSNumber *drugsComplete;
@property (nonatomic, retain) NSNumber *equipComplete;
@property (nonatomic, retain) NSNumber *teamComplete;
@property (nonatomic, retain) NSNumber *finalComplete;
@property (nonatomic, retain) NSNumber *preHospital;

@property (nonatomic, retain) NSArray *indicationChecklist;
@property (nonatomic, retain) NSMutableArray *indicationTicked;
@property (nonatomic, retain) NSArray *indicationPHEM;
@property (nonatomic, retain) NSMutableArray *teamTicked;
@property (nonatomic, retain) NSMutableArray *finalTicked;
@property (nonatomic, retain) NSMutableArray *finalChecklist;
@property (nonatomic, retain) NSArray *finalCricoid;
@property (nonatomic, retain) NSMutableArray * equipmentTicked;
@property (nonatomic, retain) NSMutableArray * confirmationTicked;
@property (nonatomic, retain) NSMutableArray * confirmationPHEM;
@property (nonatomic, retain) NSMutableArray * confirmationChecklist;

@property (nonatomic, retain) NSNumber *rocRunning;
@property (nonatomic, retain) NSNumber *rocStart;
@property (nonatomic, retain) NSNumber *rocEnd;
@property (nonatomic, retain) NSNumber *totalRoc;

@property (nonatomic, retain) NSNumber *intubationAttemptStart;
@property (nonatomic, retain) NSNumber *intubationAttemptRunning;

@property (nonatomic, retain) NSNumber *latRSI;
@property (nonatomic, retain) NSNumber *longRSI;
@property (nonatomic, retain) NSString *jobAddress;
@property (nonatomic, retain) NSNumber *gpsFix;

@property (nonatomic, retain) NSString * clGrade;
@property (nonatomic, retain) NSNumber * successfulTubeTime;

@property (nonatomic, retain) NSDate * drugsGiven;
@property (nonatomic, retain) NSDate * intubationStarted;
@property (nonatomic, retain) NSDate * intubationSuccessful;

+ (id) sharedPreO2Start;
+ (id) sharedPreO2End;
+ (id) sharedTotalPreO2;
+ (id) sharedPreO2Running;

+ (id) sharedIndicationComplete;
+ (id) sharedDrugsComplete;
+ (id) sharedEquipComplete;
+ (id) sharedTeamComplete;
+ (id) sharedFinalComplete;
+ (id) sharedPreHospital;

+ (id) sharedIndicationChecklist;
+ (id) sharedIndicationTicked;
+ (id) sharedIndicationPHEM;
+ (id) sharedTeamTicked;
+ (id) sharedFinalTicked;
+ (id) sharedFinalChecklist;
+ (id) sharedFinalCricoid;
+ (id) sharedEquipmentTicked;
+ (id) sharedConfirmationTicked;
+ (id) sharedConfirmationPHEM;
+ (id) sharedConfirmationChecklist;

+ (id) sharedRocRunning;
+ (id) sharedRocStart;
+ (id) sharedRocEnd;
+ (id) sharedtotalRoc;

+ (id) sharedIntubationAttemptStart;
+ (id) sharedIntubationAttemptRunning;

+ (id) sharedLatRSI;
+ (id) sharedLongRSI;
+ (id) sharedJobAddress;
+ (id) sharedGPSFix;

+ (id) sharedCLGrade;
+ (id) sharedSuccessfulTubeTime;

+ (id) sharedDrugsGiven;
+ (id) sharedIntubationStarted;
+ (id) sharedIntubationSuccessful;

@end
