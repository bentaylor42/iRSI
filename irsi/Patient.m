//
//  Patient.m
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "Patient.h"

@implementation Patient

@synthesize weight;
@synthesize isAdult;
@synthesize idealBodyWeight;
@synthesize ibwKnown;
@synthesize weightKnown;
@synthesize isFemale;
@synthesize age;
@synthesize ageArrayIndex;
@synthesize height;

#pragma mark Singleton Methods

+(id) sharedWeight
{
    static Patient * sharedWeight = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedWeight = [[self alloc] init];});
    return sharedWeight;
}

+(id) sharedIsAdult
{
    static Patient * sharedIsAdult = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIsAdult = [[self alloc] init];});
    return sharedIsAdult;
}

+(id) sharedIdealBodyWeight
{
    static Patient * sharedIdealBodyWeight = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIdealBodyWeight = [[self alloc] init];});
    return sharedIdealBodyWeight;
}

+(id) sharedIbwKnown
{
    static Patient * sharedIbwKnown = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIbwKnown = [[self alloc] init];});
    return sharedIbwKnown;
}

+(id) sharedWeightKnown
{
    static Patient * sharedWeightKnown = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedWeightKnown = [[self alloc] init];});
    return sharedWeightKnown;
}

+(id) sharedIsFemale
{
    static Patient * sharedIsFemale = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedIsFemale = [[self alloc] init];});
    return sharedIsFemale;
}

+(id) sharedAge
{
    static Patient * sharedAge = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedAge = [[self alloc] init];});
    return sharedAge;
}

+(id) sharedAgeArrayIndex
{
    static Patient * sharedAgeArrayIndex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedAgeArrayIndex = [[self alloc] init];});
    return sharedAgeArrayIndex;
}

+(id) sharedHeight
{
    static Patient * sharedHeight = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedHeight = [[self alloc] init];});
    return sharedHeight;
}

-(id) init
{
    if (self = [super init])
    {
        weight = [[NSNumber alloc] initWithFloat:70.0];
        isAdult = [[NSNumber alloc] initWithBool:YES];
        idealBodyWeight = [[NSNumber alloc] init];
        ibwKnown = [[NSNumber alloc] initWithBool:NO];
        weightKnown = [[NSNumber alloc] initWithBool:NO];
        isFemale = [[NSNumber alloc] initWithBool:NO];
        age = [[NSNumber alloc] init];
        ageArrayIndex = [[NSNumber alloc] initWithInt:0];
        height = [[NSNumber alloc] init];
    }
    return self;
}

-(void)dealloc
{
    // Should never be called, but here for the sake of clarity
}


@end
