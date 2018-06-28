//
//  WeekDaysCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "WeekDaysCell.h"
#import "AppUtils.h"
#import "AppConstants.h"

@implementation WeekDaysCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"WeekDaysCell";
        self.staticHeightForCell = 74;
    }
    return self;
}

@end


@implementation WeekDaysCell

- (void)setUpWithSource:(WeekDaysCellSource*)source
{
    _segmentBackView.layer.cornerRadius = _daysSegmentedControll.frame.size.height/2.0;
    _segmentBackView.layer.borderColor = self.backgroundColor.CGColor;
    _segmentBackView.layer.borderWidth = 1.0;
    
    _segmentBackView.clipsToBounds = YES;
    
    [_daysSegmentedControll setTitleTextAttributes:@{NSForegroundColorAttributeName:[AppUtils inputFieldTextColor],
                                                     NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:16]}
                                          forState:UIControlStateNormal];
    
    
    
    [_daysSegmentedControll selectAllSegments:YES];
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet new] initWithIndexSet:_daysSegmentedControll.selectedSegmentIndexes];
    
    
    
    [source.job.days enumerateObjectsUsingBlock:^(Day* day, NSUInteger idx, BOOL * _Nonnull stop) {
        [indexSet removeIndex:[day.day integerValue]];
    }];
    
    [_daysSegmentedControll selectAllSegments:NO];
    _daysSegmentedControll.selectedSegmentIndexes = indexSet;
   
    _daysSegmentedControll.delegate = source.target;
   
}

@end




