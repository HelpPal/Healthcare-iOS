//
//  HoursPerDayCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "Job.h"
@interface HoursPerDayCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,assign) SEL minusSelector;
@property (nonatomic,assign) SEL plusSelector;
@property (nonatomic,strong) Job *job;
@end

@interface HoursPerDayCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
- (void)setUpWithSource:(HoursPerDayCellSource*)source;
@end

