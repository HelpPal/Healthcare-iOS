//
//  UserDescribtionInputViewCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "UserDescribtionInputViewCell.h"

@implementation UserDescribtionInputViewCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"UserDescribtionInputViewCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 174;
  }
  return self;
}

@end


@implementation UserDescribtionInputViewCell

- (void)setUpWithSource:(UserDescribtionInputViewCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _backView.layer.cornerRadius = 19;
    _backView.clipsToBounds = YES;
    _inputTextView.delegate = source.target;
    _inputTextView.text = source.user.userDescriptionDetails;
}

@end




