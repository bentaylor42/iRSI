//
//  DrugLog.m
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DrugLog.h"

@implementation DrugLog

@synthesize drugDoseDisplayType;
@synthesize inductionConc;
@synthesize inductionDoseMax;
@synthesize inductionDoseMin;
@synthesize inductionDrug;
@synthesize relaxantsConc;
@synthesize relaxantsDoseMax;
@synthesize relaxantsDoseMin;
@synthesize relaxantsDrug;
@synthesize flush;
@synthesize emergencyConc;
@synthesize emergencyDoseMax;
@synthesize emergencyDoseMin;
@synthesize emergencyDrug;
@synthesize coInductiveConc;
@synthesize coInductiveDoseMax;
@synthesize coInductiveDoseMin;
@synthesize coInductiveDrug;
@synthesize ongoingAnalgesiaConc;
@synthesize ongoingAnalgesiaDoseMax;
@synthesize ongoingAnalgesiaDoseMin;
@synthesize ongoingAnalgesiaDrug;
@synthesize ongoingSedationConc;
@synthesize ongoingSedationDoseMax;
@synthesize ongoingSedationDoseMin;
@synthesize ongoingSedationDrug;
@synthesize otherConc;
@synthesize otherDoseMax;
@synthesize otherDoseMin;
@synthesize otherDrug;
@synthesize sectionSelected;
@synthesize vasopressorChosen;
@synthesize antimuscarinicChosen;

+ (id) sharedDrugDoseDisplayType
{
    static DrugLog * sharedDrugDoseDisplayType = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDrugDoseDisplayType = [[self alloc] init];});
    return sharedDrugDoseDisplayType;
}

+ (id) sharedInductionConc
{
    static DrugLog * sharedInductionConc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionConc = [[self alloc] init];});
    return sharedInductionConc;
}

+ (id) sharedInductionDoseMax
{
    static DrugLog * sharedInductionDoseMax = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionDoseMax = [[self alloc] init];});
    return sharedInductionDoseMax;
}

+ (id) sharedInductionDoseMin
{
    static DrugLog * sharedInductionDoseMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionDoseMin = [[self alloc] init];});
    return sharedInductionDoseMin;
}

+ (id) sharedInductionDrug
{
    static DrugLog * sharedInductionDrug = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionDrug = [[self alloc] init];});
    return sharedInductionDrug;
}

+ (id) sharedRelaxantsConc
{
    static DrugLog * sharedRelaxantsConc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRelaxantsConc = [[self alloc] init];});
    return sharedRelaxantsConc;
}

+ (id) sharedRelaxantsDoseMax
{
    static DrugLog * sharedRelaxantsDoseMax = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRelaxantsDoseMax = [[self alloc] init];});
    return sharedRelaxantsDoseMax;
}

+ (id) sharedRelaxantsDoseMin
{
    static DrugLog * sharedRelaxantsDoseMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRelaxantsDoseMin = [[self alloc] init];});
    return sharedRelaxantsDoseMin;
}

+ (id) sharedRelaxantsDrug
{
    static DrugLog * sharedRelaxantsDrug = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedRelaxantsDrug = [[self alloc] init];});
    return sharedRelaxantsDrug;
}

+ (id) sharedFlush
{
    static DrugLog * sharedFlush = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedFlush = [[self alloc] init];});
    return sharedFlush;
}

+ (id) sharedEmergencyConc
{
    static DrugLog * sharedEmergencyConc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedEmergencyConc = [[self alloc] init];});
    return sharedEmergencyConc;
}

+ (id) sharedEmergencyDoseMax
{
    static DrugLog * sharedEmergencyDoseMax = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedEmergencyDoseMax = [[self alloc] init];});
    return sharedEmergencyDoseMax;
}

+ (id) sharedEmergencyDoseMin
{
    static DrugLog * sharedEmergencyDoseMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedEmergencyDoseMin = [[self alloc] init];});
    return sharedEmergencyDoseMin;
}

+ (id) sharedEmergencyDrug
{
    static DrugLog * sharedEmergencyDrug = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedEmergencyDrug = [[self alloc] init];});
    return sharedEmergencyDrug;
}

+ (id) sharedCoinductiveConc
{
    static DrugLog * sharedCoinductiveConc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedCoinductiveConc = [[self alloc] init];});
    return sharedCoinductiveConc;
}

+ (id) sharedCoinductiveDoseMax
{
    static DrugLog * sharedCoinductiveDoseMax = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedCoinductiveDoseMax = [[self alloc] init];});
    return sharedCoinductiveDoseMax;
}

+ (id) sharedCoinductiveDoseMin
{
    static DrugLog * sharedCoinductiveDoseMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedCoinductiveDoseMin = [[self alloc] init];});
    return sharedCoinductiveDoseMin;
}

+ (id) sharedCoinductiveDrug
{
    static DrugLog * sharedCoinductiveDrug = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedCoinductiveDrug = [[self alloc] init];});
    return sharedCoinductiveDrug;
}

+ (id) sharedOngoingAnalgesiaConc
{
    static DrugLog * sharedOngoingAnalgesiaConc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOngoingAnalgesiaConc = [[self alloc] init];});
    return sharedOngoingAnalgesiaConc;
}

+ (id) sharedOngoingAnalgesiaDoseMax
{
    static DrugLog * sharedOngoingAnalgesiaDoseMax = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOngoingAnalgesiaDoseMax = [[self alloc] init];});
    return sharedOngoingAnalgesiaDoseMax;
}

+ (id) sharedOngoingAnalgesiaDoseMin
{
    static DrugLog * sharedOngoingAnalgesiaDoseMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOngoingAnalgesiaDoseMin = [[self alloc] init];});
    return sharedOngoingAnalgesiaDoseMin;
}

+ (id) sharedOngoingAnalgesiaDrug
{
    static DrugLog * sharedOngoingAnalgesiaDrug = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOngoingAnalgesiaDrug = [[self alloc] init];});
    return sharedOngoingAnalgesiaDrug;
}

+ (id) sharedOngoingSedationConc
{
    static DrugLog * sharedOngoingSedationConc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOngoingSedationConc = [[self alloc] init];});
    return sharedOngoingSedationConc;
}

+ (id) sharedOngoingSedationDoseMax
{
    static DrugLog * sharedOngoingSedationDoseMax = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOngoingSedationDoseMax = [[self alloc] init];});
    return sharedOngoingSedationDoseMax;
}

+ (id) sharedOngoingSedationDoseMin
{
    static DrugLog * sharedOngoingSedationDoseMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOngoingSedationDoseMin = [[self alloc] init];});
    return sharedOngoingSedationDoseMin;
}

+ (id) sharedOngoingSedationDrug
{
    static DrugLog * sharedOngoingSedationDrug = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOngoingSedationDrug = [[self alloc] init];});
    return sharedOngoingSedationDrug;
}

+ (id) sharedOtherConc
{
    static DrugLog * sharedOtherConc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOtherConc = [[self alloc] init];});
    return sharedOtherConc;
}

+ (id) sharedOtherDoseMax
{
    static DrugLog * sharedOtherDoseMax = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOtherDoseMax = [[self alloc] init];});
    return sharedOtherDoseMax;
}

+ (id) sharedOtherDoseMin
{
    static DrugLog * sharedOtherDoseMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOtherDoseMin = [[self alloc] init];});
    return sharedOtherDoseMin;
}

+ (id) sharedOtherDrug
{
    static DrugLog * sharedOtherDrug = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedOtherDrug = [[self alloc] init];});
    return sharedOtherDrug;
}

+ (id) sharedSectionSelected
{
    static DrugLog * sharedSectionSelected = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedSectionSelected = [[self alloc] init];});
    return sharedSectionSelected;
}

+ (id) sharedVasopressorChosen
{
    static DrugLog * sharedVasopressorChosen = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedVasopressorChosen = [[self alloc] init];});
    return sharedVasopressorChosen;
}

+ (id) sharedAntimuscarinicChosen
{
    static DrugLog * sharedAntimuscarinicChosen = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedAntimuscarinicChosen = [[self alloc] init];});
    return sharedAntimuscarinicChosen;
}


- (id) init
{
    if (self = [super init])
    {
        drugDoseDisplayType = [[NSNumber alloc] init];
        
        inductionDrug = [[NSMutableArray alloc] init];
        inductionDoseMin = [[NSMutableArray alloc] init];
        inductionDoseMax = [[NSMutableArray alloc] init];
        inductionConc = [[NSMutableArray alloc] init];
        
        relaxantsDrug = [[NSMutableArray alloc] init];
        relaxantsDoseMin = [[NSMutableArray alloc] init];
        relaxantsDoseMax = [[NSMutableArray alloc] init];
        relaxantsConc = [[NSMutableArray alloc] init];
        
        flush = [[NSMutableArray alloc] init];
        
        emergencyDrug = [[NSMutableArray alloc] init];
        emergencyDoseMin = [[NSMutableArray alloc] init];
        emergencyDoseMax = [[NSMutableArray alloc] init];
        emergencyConc = [[NSMutableArray alloc] init];
        
        coInductiveDrug = [[NSMutableArray alloc] init];
        coInductiveDoseMin = [[NSMutableArray alloc] init];
        coInductiveDoseMax = [[NSMutableArray alloc] init];
        coInductiveConc = [[NSMutableArray alloc] init];
        
        ongoingSedationDrug = [[NSMutableArray alloc] init];
        ongoingSedationDoseMin = [[NSMutableArray alloc] init];
        ongoingSedationDoseMax = [[NSMutableArray alloc] init];
        ongoingSedationConc = [[NSMutableArray alloc] init];
        
        ongoingAnalgesiaDrug = [[NSMutableArray alloc] init];
        ongoingAnalgesiaDoseMin = [[NSMutableArray alloc] init];
        ongoingAnalgesiaDoseMax = [[NSMutableArray alloc] init];
        ongoingAnalgesiaConc = [[NSMutableArray alloc] init];
        
        otherDrug = [[NSMutableArray alloc] init];
        otherDoseMin = [[NSMutableArray alloc] init];
        otherDoseMax = [[NSMutableArray alloc] init];
        otherConc = [[NSMutableArray alloc] init];
        
        sectionSelected = [[NSNumber alloc] initWithInteger:0];
        
        vasopressorChosen = [[NSNumber alloc] initWithInteger:0];
        antimuscarinicChosen = [[NSNumber alloc] initWithInteger:0];
    }
    return self;
}

@end
