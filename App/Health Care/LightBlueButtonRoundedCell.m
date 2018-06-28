//
//  LightBlueButtonRoundedCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "LightBlueButtonRoundedCell.h"
#import "AppUtils.h"
#import "UIButton+InfoObject.h"

@implementation LightBlueButtonRoundedCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"LightBlueButtonRoundedCell";
        self.staticHeightForCell = 52;
        self.buttonTitleColor = [UIColor whiteColor];
        self.buttonBackColor = [AppUtils buttonBlueColor];
        self.padding = 100;
    }
    return self;
}

@end


@implementation LightBlueButtonRoundedCell

- (void)setUpWithSource:(LightBlueButtonRoundedCellSource*)source
{
    _leftPadding.constant = _rightPadding.constant = source.padding;
    [_blueButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_blueButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    
    [_blueButton setTitle:source.buttonTitle forState:UIControlStateNormal];
    [_blueButton setTitle:source.buttonTitle forState:UIControlStateSelected];
    [_blueButton setTitle:source.buttonTitle forState:UIControlStateHighlighted];
    
      _blueButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_blueButton sizeToFit];
   
    _blueButton.backgroundColor = source.buttonBackColor;
    
    [_blueButton setTitleColor:source.buttonTitleColor forState:UIControlStateNormal];
    [_blueButton setTitleColor:source.buttonTitleColor forState:UIControlStateSelected];
    [_blueButton setTitleColor:source.buttonTitleColor forState:UIControlStateHighlighted];
    _blueButton.infoObject = source.object;
    
    self.clipsToBounds = YES;
}

@end




