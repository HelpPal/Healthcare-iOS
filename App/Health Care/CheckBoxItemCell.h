//
//  CheckBoxItemCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "UIGestureRecognizer+InfoObject.h"

@interface CheckBoxItemCellSource : IDDCellSource

@property (assign, nonatomic)  float fontSize;
@property (assign, nonatomic)  NSTextAlignment textAlignment;
@property (assign, nonatomic)  BOOL isSelected;
@property (assign, nonatomic)  NSNumber* objectId;

@end

@interface CheckBoxItemCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImage;

- (void)setUpWithSource:(CheckBoxItemCellSource*)source;
@end

