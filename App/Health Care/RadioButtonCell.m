//
//  RadioButtonCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "RadioButtonCell.h"
#import "AppUtils.h"

@implementation RadioButtonCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"RadioButtonCell";
        self.textAlignment = NSTextAlignmentLeft;
        self.fontSize = 20;
        self.staticHeightForCell = 70.0;
    }
  return self;
}

@end


@implementation RadioButtonCell


- (void)setUpWithSource:(RadioButtonCellSource*)source
{
    
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    _tapGesture.infoObject = @(source.itemTag);
    
    _infoLabel.text = source.title;
    _infoLabel.font = [UIFont fontWithName:_infoLabel.font.fontName size:source.fontSize];
    _infoLabel.textAlignment = source.textAlignment;
    _infoLabel.textColor = source.isSelected ? [AppUtils inputFieldTextColor] : [UIColor blackColor] ;
    
    NSString * imageName = [@"radioButton" stringByAppendingFormat:@"%d",source.isSelected];
    _radioImage.image = [UIImage imageNamed:imageName];
    

}

@end




