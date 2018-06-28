//
//  SpaceCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "SpaceCell.h"
#import "UIButton+InfoObject.h"

@implementation SpaceCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"SpaceCell";
      self.backgroundColor = [UIColor whiteColor];
      self.multipleSelection = YES;
      self.staticHeightForCell = 20;
  }
  return self;
}

@end


@implementation SpaceCell

- (void)setUpWithSource:(SpaceCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
}

@end




