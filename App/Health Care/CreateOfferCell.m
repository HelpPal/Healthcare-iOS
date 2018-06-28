//
//  CreateOfferCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "CreateOfferCell.h"
#import "UIGestureRecognizer+InfoObject.h"

@implementation CreateOfferCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"CreateOfferCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 48;
      self.multipleSelection = YES;
  }
  return self;
}

@end


@implementation CreateOfferCell

- (void)setUpWithSource:(CreateOfferCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    _titleLabel.text = source.title;
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    
}

@end




