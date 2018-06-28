//
//  HoursPerDayCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "HoursPerDayCell.h"
#import "AppUtils.h"
@implementation HoursPerDayCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"HoursPerDayCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 68;
  }
  return self;
}

@end


@implementation HoursPerDayCell

- (void)setUpWithSource:(HoursPerDayCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    
    [_minusButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_minusButton addTarget:source.target action:source.minusSelector forControlEvents:UIControlEventTouchUpInside];
    
    [_plusButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_plusButton addTarget:source.target action:source.plusSelector forControlEvents:UIControlEventTouchUpInside];
    _hoursLabel.text = [NSString stringWithFormat:@"%@",source.job.hours];
}




@end




