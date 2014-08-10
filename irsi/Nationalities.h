//
//  Nationalities.h
//  irsi
//
//  Created by Ben Taylor on 29/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nationalities : NSObject

{
    NSArray *nationalityArray;
    NSNumber *nationality;
    NSArray *drugLabels;
    NSArray *nationalityStringArray;
}

@property (nonatomic, retain) NSArray *nationalityArray;
@property (nonatomic, retain) NSNumber *nationality;
@property (nonatomic, retain) NSArray *drugLabels;
@property (nonatomic, retain) NSArray *nationalityStringArray;

+ (id) sharedNationalityArray;
+ (id) sharedNationality;
+ (id) sharedDrugLabels;
+ (id) sharedNationalityStringArray;

@end
