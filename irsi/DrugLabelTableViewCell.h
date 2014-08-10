//
//  DrugLabelTableViewCell.h
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrugLabelTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelDoseType;

@property (strong, nonatomic) IBOutlet UILabel *labelDrugLabel;

@property (strong, nonatomic) IBOutlet UITextField *textFieldConcentration;

@property (strong, nonatomic) IBOutlet UILabel *labelDisplayMls;

@end
