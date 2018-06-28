//
//  DoubleRadioButtonCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "DoubleRadioButtonCell.h"
#import "AppUtils.h"

@implementation DoubleRadioButtonCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"DoubleRadioButtonCell";
        
        self.staticHeightForCell = 61;
    }
  return self;
}

@end


@implementation DoubleRadioButtonCell


- (void)setUpWithSource:(DoubleRadioButtonCellSource*)source
{
    _leftItemLabel.text = source.leftItemName;
    _rightItemLabel.text = source.rightItemName;
    _backView.layer.borderColor = [AppUtils separatorsColor].CGColor;
    _backView.layer.borderWidth = 0.5;
    _backView.clipsToBounds = YES;
    
    
    [_leftItemButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_rightItemButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    
    [_leftItemButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    [_rightItemButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    
    
    if (source.selectedItem == 2) {
        source.selectedItem = 0;
    }
    
    
    int choice = source.selectedItem == 0;
    
    NSString * imageName = [@"radioButton" stringByAppendingFormat:@"%d",choice];
    _leftItemRadioImage.image = [UIImage imageNamed:imageName];
    
    imageName = [@"radioButton" stringByAppendingFormat:@"%d",!choice];
    _rightItemRadioImage.image = [UIImage imageNamed:imageName];

    
    _leftItemLabel.textColor = (source.selectedItem == 0) ? [AppUtils  inputFieldTextColor] : [UIColor blackColor];
    _rightItemLabel.textColor = (source.selectedItem == 1) ? [AppUtils  inputFieldTextColor] : [UIColor blackColor];

}

@end




