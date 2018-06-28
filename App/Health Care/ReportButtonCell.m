//
//  ReportButtonCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "ReportButtonCell.h"

@implementation ReportButtonCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"ReportButtonCell";
      self.staticHeightForCell = 56;
  }
  return self;
}

@end


@implementation ReportButtonCell

- (void)setUpWithSource:(ReportButtonCellSource*)source
{
    
    
    [_blueButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_blueButton addTarget:source.target action:source.buttonSelector forControlEvents:UIControlEventTouchUpInside];
    
    [_blueButton setTitle:source.buttonTitle forState:UIControlStateNormal];
    [_blueButton setTitle:source.buttonTitle forState:UIControlStateSelected];
    [_blueButton setTitle:source.buttonTitle forState:UIControlStateHighlighted];
    
    
   
     _blueButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_blueButton sizeToFit];
    _buttonConstraintWidth.constant = _blueButton.frame.size.width + 10;
    
}

@end




