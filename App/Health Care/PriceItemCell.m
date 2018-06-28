//
//  PriceItemCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "PriceItemCell.h"

@implementation PriceItemCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"PriceItemCell";
  }
  return self;
}

@end


@implementation PriceItemCell

- (void)setUpWithSource:(PriceItemCellSource*)source
{
    _priceLabel.text = source.price;
    _priceLabel.layer.cornerRadius = 20;
    _priceLabel.clipsToBounds = YES;

    
    [_priceLabel sizeToFit];
    float space = self.frame.size.width - _priceLabel.frame.size.width;
    _leftSpace.constant = _rightSpace.constant = space/2 - 18;
}

@end




