//
//  WeekDaysCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "MultiSelectSegmentedControl.h"
#import "AppConstants.h"
#import "Job.h"

@interface WeekDaysCellSource : IDDCellSource
@property (nonatomic,strong)  Job* job;
@end

@interface WeekDaysCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIView *segmentBackView;
@property (weak, nonatomic) IBOutlet MultiSelectSegmentedControl *daysSegmentedControll;

- (void)setUpWithSource:(WeekDaysCellSource*)source;
@end

