//
//  InductionAgents.m
//  irsi
//
//  Created by Ben Taylor on 28/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "InductionAgents.h"

@implementation InductionAgents

@synthesize inductionIsMaxMin;
@synthesize inductionIsSingleAdultDose;
@synthesize inductionLabelType;
@synthesize inductionMaximumDose;
@synthesize inductionMinimumDose;
@synthesize inductionName;
@synthesize inductionNormalConc;
@synthesize inductionSingleAdultDose;
@synthesize inductionSingleScaledDose;
@synthesize inductionUnitType;
@synthesize inductionClass;
@synthesize isVasopressor;
@synthesize manualDose;
@synthesize safePaeds;
@synthesize paedsMax;
@synthesize paedsMin;
@synthesize paedsSingle;
@synthesize paedsMaxTotal;

+(id) sharedInductionIsMaxMin
{
    static InductionAgents * sharedInductionIsMaxMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionIsMaxMin = [[self alloc] init];});
    return sharedInductionIsMaxMin;
}

+(id) sharedInductionIsSingleAdultDose
{
    static InductionAgents * sharedInductionIsSingleAdultDose = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionIsSingleAdultDose = [[self alloc] init];});
    return sharedInductionIsSingleAdultDose;
}

+(id) sharedInductionLabelType
{
    static InductionAgents * sharedInductionLabelType = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionLabelType = [[self alloc] init];});
    return sharedInductionLabelType;
}

+(id) sharedInductionMaximumDose
{
    static InductionAgents * sharedInductionMaximumDose = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionMaximumDose = [[self alloc] init];});
    return sharedInductionMaximumDose;
}

+(id) sharedInductionMinimumDose
{
    static InductionAgents * sharedInductionMinimumDose = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionMinimumDose = [[self alloc] init];});
    return sharedInductionMinimumDose;
}

+(id) sharedInductionName
{
    static InductionAgents * sharedInductionName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionName = [[self alloc] init];});
    return sharedInductionName;
}

+(id) sharedInductionNormalConc
{
    static InductionAgents * sharedInductionNormalConc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionNormalConc = [[self alloc] init];});
    return sharedInductionNormalConc;
}

+(id) sharedInductionSingleAdultDose
{
    static InductionAgents * sharedInductionSingleAdultDose = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionSingleAdultDose = [[self alloc] init];});
    return sharedInductionSingleAdultDose;
}

+(id) sharedInductionSingleScaledDose
{
    static InductionAgents * sharedInductionSingleScaledDose = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionSingleScaledDose = [[self alloc] init];});
    return sharedInductionSingleScaledDose;
}

+(id) sharedInductionUnitType
{
    static InductionAgents * sharedInductionUnitType = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionUnitType = [[self alloc] init];});
    return sharedInductionUnitType;
}

+(id) sharedInductionClass
{
    static InductionAgents * sharedInductionClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedInductionClass = [[self alloc] init];});
    return sharedInductionClass;
}

+(id) sharedIsVasopressor
{
    static InductionAgents * sharedIsVasopressor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIsVasopressor = [[self alloc] init];});
    return sharedIsVasopressor;
}

+(id) sharedManualDose
{
    static InductionAgents * sharedManualDose = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedManualDose = [[self alloc] init];});
    return sharedManualDose;
}

+(id) sharedPaedsMax
{
    static InductionAgents * sharedPaedsMax = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPaedsMax = [[self alloc] init];});
    return sharedPaedsMax;
}

+(id) sharedPaedsMin
{
    static InductionAgents * sharedPaedsMin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPaedsMin = [[self alloc] init];});
    return sharedPaedsMin;
}

+(id) sharedPaedsSingle
{
    static InductionAgents * sharedPaedsSingle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPaedsSingle = [[self alloc] init];});
    return sharedPaedsSingle;
}

+(id) sharedSafePaeds
{
    static InductionAgents * sharedSafePaeds = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedSafePaeds = [[self alloc] init];});
    return sharedSafePaeds;
}

+(id) sharedPaedsMaxTotal
{
    static InductionAgents * sharedPaedsMaxTotal = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedPaedsMaxTotal = [[self alloc] init];});
    return sharedPaedsMaxTotal;
}

- (id) init
{
    if (self = [super init])
    {
        inductionIsMaxMin = [[NSMutableArray alloc] init];
        inductionClass = [[NSMutableArray alloc] init];
        inductionIsSingleAdultDose = [[NSMutableArray alloc] init];
        inductionLabelType = [[NSMutableArray alloc] init];
        inductionMaximumDose = [[NSMutableArray alloc] init];
        inductionMinimumDose = [[NSMutableArray alloc] init];
        inductionName = [[NSMutableArray alloc] init];
        inductionNormalConc = [[NSMutableArray alloc] init];
        inductionSingleAdultDose = [[NSMutableArray alloc] init];
        inductionSingleScaledDose = [[NSMutableArray alloc] init];
        inductionUnitType = [[NSMutableArray alloc] init];
        isVasopressor = [[NSMutableArray alloc] init];
        manualDose = [[NSMutableArray alloc] initWithObjects:0, nil];
        safePaeds = [[NSMutableArray alloc] init];
        paedsMin = [[NSMutableArray alloc] init];
        paedsMax = [[NSMutableArray alloc] init];
        paedsSingle = [[NSMutableArray alloc] init];
        paedsMaxTotal = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
