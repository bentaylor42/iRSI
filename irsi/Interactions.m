//
//  Interactions.m
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "Interactions.h"

@implementation Interactions

@synthesize airwayWindowOpen;
@synthesize nodesatWindowOpen;
@synthesize drugSelectionSection;
@synthesize drugSelectorWindowOpen;
@synthesize changedDoseDisplayType;
@synthesize deleteDrugRow;
@synthesize deleteDrugSection;
@synthesize demographicsOpen;

+ (id) sharedAirwayWindowOpen
{
    static Interactions *sharedAirwayWindowOpen = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedAirwayWindowOpen = [[self alloc] init];});
    return sharedAirwayWindowOpen;
}

+ (id) sharedNODESATWindowOpen
{
    static Interactions *sharedNODESATWindowOpen = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedNODESATWindowOpen = [[self alloc] init];});
    return sharedNODESATWindowOpen;
}

+ (id) sharedDrugSelectionSection
{
    static Interactions *sharedDrugSelectionSection = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDrugSelectionSection = [[self alloc] init];});
    return sharedDrugSelectionSection;
}

+ (id) sharedDrugSelectorWindowOpen
{
    static Interactions *sharedDrugSelectorWindowOpen = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDrugSelectorWindowOpen = [[self alloc] init];});
    return sharedDrugSelectorWindowOpen;
}

+ (id) sharedChangedDoseDisplayType
{
    static Interactions *sharedChangedDoseDisplayType = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedChangedDoseDisplayType = [[self alloc] init];});
    return sharedChangedDoseDisplayType;
}

+ (id) sharedDeleteDrugSection
{
    static Interactions *sharedDeleteDrugSection = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDeleteDrugSection = [[self alloc] init];});
    return sharedDeleteDrugSection;
}

+ (id) sharedDeleteDrugRow
{
    static Interactions *sharedDeleteDrugRow = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDeleteDrugRow = [[self alloc] init];});
    return sharedDeleteDrugRow;
}

+ (id) sharedDemographicsOpen
{
    static Interactions *sharedDemographicsOpen = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDemographicsOpen = [[self alloc] init];});
    return sharedDemographicsOpen;
}

- (id) init
{
    if (self = [super init])
    {
        airwayWindowOpen = [[NSNumber alloc] initWithBool:NO];
        nodesatWindowOpen = [[NSNumber alloc] initWithBool:NO];
        
        drugSelectorWindowOpen = [[NSNumber alloc] initWithBool:NO];
        drugSelectionSection = [[NSNumber alloc] init];
        changedDoseDisplayType = [[NSNumber alloc] initWithBool:NO];
        deleteDrugRow = [[NSNumber alloc] initWithInteger:0];
        deleteDrugSection = [[NSNumber alloc] initWithInteger:0];
        demographicsOpen = [[NSNumber alloc] initWithBool:NO];
    }
    return self;
}

@end
