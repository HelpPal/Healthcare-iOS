//
//  JobDescribtionInputViewCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "JobDescribtionInputViewCell.h"

@implementation JobDescribtionInputViewCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"JobDescribtionInputViewCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 174;
  }
  return self;
}

@end


@implementation JobDescribtionInputViewCell

- (void)setUpWithSource:(JobDescribtionInputViewCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _backView.layer.cornerRadius = 19;
    _backView.clipsToBounds = YES;
    _inputTextView.delegate = source.target;
    _inputTextView.text = source.job.information;
}

@end




