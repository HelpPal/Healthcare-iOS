//
//  ShowJobDetailsCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "ShowJobDetailsCell.h"
#import "UIGestureRecognizer+InfoObject.h"
#import "AppUtils.h"

@implementation ShowJobDetailsCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"ShowJobDetailsCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 84;
      self.multipleSelection = YES;
  }
  return self;
}

@end


@implementation ShowJobDetailsCell

- (void)setUpWithSource:(ShowJobDetailsCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _titleLabel.text = source.job.title;
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    _tapGesture.infoObject = source.job;
}

@end




