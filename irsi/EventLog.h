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
    
    NSMutableArray * equipmentTicked;
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

@property (nonatomic, retain) NSMutableArray * equipmentTicked;

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

+ (id) sharedEquipmentTicked;

@end
