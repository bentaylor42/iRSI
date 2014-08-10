//
//  Nationalities.m
//  irsi
//
//  Created by Ben Taylor on 29/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "Nationalities.h"

@implementation Nationalities

@synthesize nationalityArray;
@synthesize nationality;
@synthesize drugLabels;
@synthesize nationalityStringArray;

+(id) sharedDrugLabels
{
    static Nationalities * sharedDrugLabels = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedDrugLabels = [[self alloc] init];});
    return sharedDrugLabels;
}

+(id) sharedNationality
{
    static Nationalities * sharedNationality = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedNationality = [[self alloc] init];});
    return sharedNationality;
}

+(id) sharedNationalityArray
{
    static Nationalities * sharedNationalityArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedNationalityArray = [[self alloc] init];});
    return sharedNationalityArray;
}

+(id) sharedNationalityStringArray
{
    static Nationalities * sharedNationalityStringArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedNationalityStringArray = [[self alloc] init];});
    return sharedNationalityStringArray;
}

- (id) init;
{
    if (self = [super init])
    {
        nationality = [[NSNumber alloc] initWithInteger:1];
        drugLabels = [[NSArray alloc] init];
        nationalityArray = [[NSArray alloc] initWithObjects:@"Template", @"UK", nil];
        nationalityStringArray = [[NSArray alloc] initWithObjects:@"StringsUK", @"StringsUK", nil];
    }
    return self;
}

@end
