//
//  BlueButtonRoundedCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "BlueButtonRoundedCell.h"
#import "AppUtils.h"
#import "UIButton+InfoObject.h"

@implementation BlueButtonRoundedCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"BlueButtonRoundedCell";
        self.staticHeightForCell = 52;
        self.buttonTitleColor = [UIColor whiteColor];
        self.buttonBackColor = [AppUtils buttonBlueColor];
        self.padding = 100;
    }
    return self;
}

@end


@implementation BlueButtonRoundedCell

- (void)setUpWithSource:(BlueButtonRoundedCellSource*)source
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
    
    _blueButton.alpha = 1.0;
    _blueButton.userInteractionEnabled = YES;
    if (source.blockButton) {
        _blueButton.alpha = 0.4;
        _blueButton.userInteractionEnabled = NO;
    }
    self.clipsToBounds = YES;
}

@end




