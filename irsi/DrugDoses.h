//
//  DrugDoses.h
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugDoses : NSObject

@property (strong, nonatomic) NSString *drugName;
@property (nonatomic, readwrite) float doseMin;
@property (nonatomic, readwrite) float doseMax;
@property (nonatomic, readwrite) int concentration;
@property (nonatomic, readwrite) float volumeMin;
@property (nonatomic, readwrite) float volumeMax;
@property (nonatomic, readwrite) float weight;

- (float) volumeMaxCalc;
- (float) volumeMinCalc;

@end
