//
//  RadioButtonCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "UIGestureRecognizer+InfoObject.h"


@interface RadioButtonCellSource : IDDCellSource


@property (assign, nonatomic)  float fontSize;
@property (assign, nonatomic)  NSTextAlignment textAlignment;
@property (assign, nonatomic)  BOOL isSelected;
@property (assign, nonatomic)  NSInteger itemTag;
@end

@interface RadioButtonCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *radioImage;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;


- (void)setUpWithSource:(RadioButtonCellSource*)source;
@end

