//
//  DrugLog.h
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugLog : NSObject
{
    NSNumber *drugDoseDisplayType;
    
    NSMutableArray *inductionDrug;
    NSMutableArray *inductionConc;
    NSMutableArray *inductionDoseMin;
    NSMutableArray *inductionDoseMax;
    
    NSMutableArray *relaxantsDrug;
    NSMutableArray *relaxantsConc;
    NSMutableArray *relaxantsDoseMin;
    NSMutableArray *relaxantsDoseMax;
    
    NSMutableArray *flush;
    
    NSMutableArray *emergencyDrug;
    NSMutableArray *emergencyConc;
    NSMutableArray *emergencyDoseMin;
    NSMutableArray *emergencyDoseMax;
    
    NSMutableArray *coInductiveDrug;
    NSMutableArray *coInductiveConc;
    NSMutableArray *coInductiveDoseMin;
    NSMutableArray *coInductiveDoseMax;
    
    NSMutableArray *ongoingSedationDrug;
    NSMutableArray *ongoingSedationConc;
    NSMutableArray *ongoingSedationDoseMin;
    NSMutableArray *ongoingSedationDoseMax;
    
    NSMutableArray *ongoingAnalgesiaDrug;
    NSMutableArray *ongoingAnalgesiaConc;
    NSMutableArray *ongoingAnalgesiaDoseMin;
    NSMutableArray *ongoingAnalgesiaDoseMax;
    
    NSMutableArray *otherDrug;
    NSMutableArray *otherConc;
    NSMutableArray *otherDoseMin;
    NSMutableArray *otherDoseMax;
    
    NSNumber *sectionSelected;
    
    NSNumber *vasopressorChosen;
    NSNumber *antimuscarinicChosen;
}

@property (nonatomic, retain) NSNumber *drugDoseDisplayType;

@property (nonatomic, retain) NSMutableArray *inductionDrug;
@property (nonatomic, retain) NSMutableArray *inductionConc;
@property (nonatomic, retain) NSMutableArray *inductionDoseMin;
@property (nonatomic, retain) NSMutableArray *inductionDoseMax;

@property (nonatomic, retain) NSMutableArray *relaxantsDrug;
@property (nonatomic, retain) NSMutableArray *relaxantsConc;
@property (nonatomic, retain) NSMutableArray *relaxantsDoseMin;
@property (nonatomic, retain) NSMutableArray *relaxantsDoseMax;

@property (nonatomic, retain) NSMutableArray *flush;

@property (nonatomic, retain) NSMutableArray *emergencyDrug;
@property (nonatomic, retain) NSMutableArray *emergencyConc;
@property (nonatomic, retain) NSMutableArray *emergencyDoseMin;
@property (nonatomic, retain) NSMutableArray *emergencyDoseMax;

@property (nonatomic, retain) NSMutableArray *coInductiveDrug;
@property (nonatomic, retain) NSMutableArray *coInductiveConc;
@property (nonatomic, retain) NSMutableArray *coInductiveDoseMin;
@property (nonatomic, retain) NSMutableArray *coInductiveDoseMax;

@property (nonatomic, retain) NSMutableArray *ongoingSedationDrug;
@property (nonatomic, retain) NSMutableArray *ongoingSedationConc;
@property (nonatomic, retain) NSMutableArray *ongoingSedationDoseMin;
@property (nonatomic, retain) NSMutableArray *ongoingSedationDoseMax;

@property (nonatomic, retain) NSMutableArray *ongoingAnalgesiaDrug;
@property (nonatomic, retain) NSMutableArray *ongoingAnalgesiaConc;
@property (nonatomic, retain) NSMutableArray *ongoingAnalgesiaDoseMin;
@property (nonatomic, retain) NSMutableArray *ongoingAnalgesiaDoseMax;

@property (nonatomic, retain) NSMutableArray *otherDrug;
@property (nonatomic, retain) NSMutableArray *otherConc;
@property (nonatomic, retain) NSMutableArray *otherDoseMin;
@property (nonatomic, retain) NSMutableArray *otherDoseMax;

@property (nonatomic, retain) NSNumber *sectionSelected;

@property (nonatomic, retain) NSNumber *vasopressorChosen;
@property (nonatomic, retain) NSNumber *antimuscarinicChosen;

+ (id) sharedDrugDoseDisplayType;

+ (id) sharedInductionDrug;
+ (id) sharedInductionConc;
+ (id) sharedInductionDoseMin;
+ (id) sharedInductionDoseMax;

+ (id) sharedRelaxantsDrug;
+ (id) sharedRelaxantsConc;
+ (id) sharedRelaxantsDoseMin;
+ (id) sharedRelaxantsDoseMax;

+ (id) sharedFlush;

+ (id) sharedEmergencyDrug;
+ (id) sharedEmergencyConc;
+ (id) sharedEmergencyDoseMin;
+ (id) sharedEmergencyDoseMax;

+ (id) sharedCoinductiveDrug;
+ (id) sharedCoinductiveConc;
+ (id) sharedCoinductiveDoseMin;
+ (id) sharedCoinductiveDoseMax;

+ (id) sharedOngoingSedationDrug;
+ (id) sharedOngoingSedationConc;
+ (id) sharedOngoingSedationDoseMin;
+ (id) sharedOngoingSedationDoseMax;

+ (id) sharedOngoingAnalgesiaDrug;
+ (id) sharedOngoingAnalgesiaConc;
+ (id) sharedOngoingAnalgesiaDoseMin;
+ (id) sharedOngoingAnalgesiaDoseMax;

+ (id) sharedOtherDrug;
+ (id) sharedOtherConc;
+ (id) sharedOtherDoseMin;
+ (id) sharedOtherDoseMax;

+ (id) sharedSectionSelected;

+ (id) sharedVasopressorChosen;
+ (id) sharedAntimuscarinicChosen;

@end
