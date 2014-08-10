//
//  DrugDoses.m
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DrugDoses.h"

@implementation DrugDoses

- (float) volumeMaxCalc
{
    float totalDose = self.weight * self.doseMax;
    self.volumeMax = totalDose / self.concentration;
    
    return self.volumeMax;
}

- (float) volumeMinCalc
{
    float totalDose = self.weight *self.doseMin;
    self.volumeMin = totalDose / self.concentration;
    
    return self.volumeMin;
}

@end
