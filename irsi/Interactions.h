//
//  Interactions.h
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interactions : NSObject
{
    NSNumber *airwayWindowOpen;
    NSNumber *nodesatWindowOpen;
    
    NSNumber *drugSelectorWindowOpen;
    NSNumber *drugSelectionSection;
    NSNumber *changedDoseDisplayType;
    NSNumber *deleteDrugSection;
    NSNumber *deleteDrugRow;
    NSNumber *demographicsOpen;
}

@property (nonatomic, retain) NSNumber *airwayWindowOpen;
@property (nonatomic, retain) NSNumber *nodesatWindowOpen;

@property (nonatomic, retain) NSNumber *drugSelectorWindowOpen;
@property (nonatomic, retain) NSNumber *drugSelectionSection;
@property (nonatomic, retain) NSNumber *changedDoseDisplayType;
@property (nonatomic, retain) NSNumber *deleteDrugSection;
@property (nonatomic, retain) NSNumber *deleteDrugRow;
@property (nonatomic, retain) NSNumber *demographicsOpen;

+ (id) sharedAirwayWindowOpen;
+ (id) sharedNODESATWindowOpen;

+ (id) sharedDrugSelectorWindowOpen;
+ (id) sharedDrugSelectionSection;
+ (id) sharedChangedDoseDisplayType;
+ (id) sharedDeleteDrugSection;
+ (id) sharedDeleteDrugRow;
+ (id) sharedDemographicsOpen;

@end
