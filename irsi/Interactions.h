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
    
    NSNumber *transitionToRoc;
    NSNumber *transitionToGPS;
    NSNumber *transitionToConfirm;
    NSNumber *transitionToEmergency;
    NSNumber *resetAll;
    NSNumber *triggerReport;
}

@property (nonatomic, retain) NSNumber *airwayWindowOpen;
@property (nonatomic, retain) NSNumber *nodesatWindowOpen;

@property (nonatomic, retain) NSNumber *drugSelectorWindowOpen;
@property (nonatomic, retain) NSNumber *drugSelectionSection;
@property (nonatomic, retain) NSNumber *changedDoseDisplayType;
@property (nonatomic, retain) NSNumber *deleteDrugSection;
@property (nonatomic, retain) NSNumber *deleteDrugRow;
@property (nonatomic, retain) NSNumber *demographicsOpen;

@property (nonatomic, retain) NSNumber *transitionToRoc;
@property (nonatomic, retain) NSNumber *transitionToGPS;
@property (nonatomic, retain) NSNumber *transitionToConfirm;
@property (nonatomic, retain) NSNumber *resetAll;
@property (nonatomic, retain) NSNumber *triggerReport;
@property (nonatomic, retain) NSNumber *transitionToEmergency;

+ (id) sharedAirwayWindowOpen;
+ (id) sharedNODESATWindowOpen;

+ (id) sharedDrugSelectorWindowOpen;
+ (id) sharedDrugSelectionSection;
+ (id) sharedChangedDoseDisplayType;
+ (id) sharedDeleteDrugSection;
+ (id) sharedDeleteDrugRow;
+ (id) sharedDemographicsOpen;

+ (id) sharedTransitionToRoc;
+ (id) sharedTransitionToGPS;
+ (id) sharedTransitionToConfirm;
+ (id) sharedResetAll;
+ (id) sharedTriggerReport;
+ (id) sharedTransitionToEmergency;

@end
