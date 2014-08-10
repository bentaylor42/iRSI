//
//  InductionAgents.h
//  irsi
//
//  Created by Ben Taylor on 28/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InductionAgents : NSObject
{
    NSMutableArray * inductionName;
    NSMutableArray * inductionClass;
    NSMutableArray * inductionIsMaxMin;
    NSMutableArray * inductionIsSingleAdultDose;
    NSMutableArray * inductionMinimumDose;
    NSMutableArray * inductionMaximumDose;
    NSMutableArray * inductionSingleScaledDose;
    NSMutableArray * inductionSingleAdultDose;
    NSMutableArray * inductionNormalConc;
    NSMutableArray * inductionUnitType;
    NSMutableArray * inductionLabelType;
    NSMutableArray * isVasopressor;
    NSMutableArray * manualDose;
    NSMutableArray * safePaeds;
    NSMutableArray * paedsMin;
    NSMutableArray * paedsMax;
    NSMutableArray * paedsSingle;
    NSMutableArray * paedsMaxTotal;
}

@property (nonatomic, retain) NSMutableArray * inductionName;
@property (nonatomic, retain) NSMutableArray * inductionClass;
@property (nonatomic, retain) NSMutableArray * inductionIsMaxMin;
@property (nonatomic, retain) NSMutableArray * inductionIsSingleAdultDose;
@property (nonatomic, retain) NSMutableArray * inductionMinimumDose;
@property (nonatomic, retain) NSMutableArray * inductionMaximumDose;
@property (nonatomic, retain) NSMutableArray * inductionSingleScaledDose;
@property (nonatomic, retain) NSMutableArray * inductionSingleAdultDose;
@property (nonatomic, retain) NSMutableArray * inductionNormalConc;
@property (nonatomic, retain) NSMutableArray * inductionUnitType;
@property (nonatomic, retain) NSMutableArray * inductionLabelType;
@property (nonatomic, retain) NSMutableArray * isVasopressor;
@property (nonatomic, retain) NSMutableArray * manualDose;
@property (nonatomic, retain) NSMutableArray * safePaeds;
@property (nonatomic, retain) NSMutableArray * paedsMin;
@property (nonatomic, retain) NSMutableArray * paedsMax;
@property (nonatomic, retain) NSMutableArray * paedsSingle;
@property (nonatomic, retain) NSMutableArray * paedsMaxTotal;

+ (id) sharedInductionName;
+ (id) sharedInductionClass;
+ (id) sharedInductionIsMaxMin;
+ (id) sharedInductionIsSingleAdultDose;
+ (id) sharedInductionMinimumDose;
+ (id) sharedInductionMaximumDose;
+ (id) sharedInductionSingleScaledDose;
+ (id) sharedInductionSingleAdultDose;
+ (id) sharedInductionNormalConc;
+ (id) sharedInductionUnitType;
+ (id) sharedInductionLabelType;
+ (id) sharedIsVasopressor;
+ (id) sharedManualDose;
+ (id) sharedSafePaeds;
+ (id) sharedPaedsMin;
+ (id) sharedPaedsMax;
+ (id) sharedPaedsSingle;
+ (id) sharedPaedsMaxTotal;

@end
