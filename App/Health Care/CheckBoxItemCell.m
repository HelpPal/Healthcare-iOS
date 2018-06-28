//
//  CheckBoxItemCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "CheckBoxItemCell.h"
#import "AppUtils.h"
#import "UIButton+InfoObject.h"
@implementation CheckBoxItemCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"CheckBoxItemCell";
        self.textAlignment = NSTextAlignmentLeft;
        self.fontSize = 20;
        self.staticHeightForCell = 70.0;
    }
  return self;
}

@end


@implementation CheckBoxItemCell


- (void)setUpWithSource:(CheckBoxItemCellSource*)source
{
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    _tapGesture.infoObject = source.objectId;
    _infoLabel.text = source.title;
    _infoLabel.font = [UIFont fontWithName:_infoLabel.font.fontName size:source.fontSize];
    _infoLabel.textAlignment = source.textAlignment;
    _infoLabel.textColor = source.isSelected ? [AppUtils inputFieldTextColor] : [UIColor blackColor] ;
    
    NSString * imageName = [@"checkBoxImage" stringByAppendingFormat:@"%d",source.isSelected];
    _checkBoxImage.image = [UIImage imageNamed:imageName];
}


-(IBAction)selectItem:(UIButton*)sender
{
    int tag = 1 - (int)sender.tag;
    sender.tag = tag;
    NSString * imageName = [@"checkBoxImage" stringByAppendingFormat:@"%d",tag];
    _checkBoxImage.image = [UIImage imageNamed:imageName];
}
@end




