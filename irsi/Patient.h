//
//  Patient.h
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject
{
    NSNumber *weight;
    NSNumber *isAdult;
    NSNumber *idealBodyWeight;
    NSNumber *ibwKnown;
    NSNumber *weightKnown;
    NSNumber *isFemale;
    NSNumber *age;
    NSNumber *ageArrayIndex;
    NSNumber *height;
    NSNumber *tubeSize;
    NSNumber *isCuffedTube;
    NSNumber *tubeLength;
    NSNumber *isNasalTube;
}

@property (nonatomic, retain) NSNumber *weight;
@property (nonatomic, retain) NSNumber *isAdult;
@property (nonatomic, retain) NSNumber *idealBodyWeight;
@property (nonatomic, retain) NSNumber *ibwKnown;
@property (nonatomic, retain) NSNumber *weightKnown;
@property (nonatomic, retain) NSNumber *isFemale;
@property (nonatomic, retain) NSNumber *age;
@property (nonatomic, retain) NSNumber *ageArrayIndex;
@property (nonatomic, retain) NSNumber *height;
@property (nonatomic, retain) NSNumber *tubeSize;
@property (nonatomic, retain) NSNumber *isCuffedTube;
@property (nonatomic, retain) NSNumber *tubeLength;
@property (nonatomic, retain) NSNumber *isNasalTube;

+ (id) sharedWeight;
+ (id) sharedIsAdult;
+ (id) sharedIdealBodyWeight;
+ (id) sharedIbwKnown;
+ (id) sharedWeightKnown;
+ (id) sharedIsFemale;
+ (id) sharedAge;
+ (id) sharedAgeArrayIndex;
+ (id) sharedHeight;
+ (id) sharedTubeSize;
+ (id) sharedIsCuffedTube;
+ (id) sharedTubeLength;
+ (id) sharedIsNasalTube;

@end
