//
//  DoubleRadioButtonCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "AppConstants.h"

@interface DoubleRadioButtonCellSource : IDDCellSource
@property (nonatomic,assign) NSString * leftItemName;
@property (nonatomic,assign) NSString * rightItemName;
@property (nonatomic,assign) NSInteger selectedItem;

@end

@interface DoubleRadioButtonCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *leftItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightItemLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftItemRadioImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightItemRadioImage;

@property (weak, nonatomic) IBOutlet UIButton *leftItemButton;
@property (weak, nonatomic) IBOutlet UIButton *rightItemButton;

- (void)setUpWithSource:(DoubleRadioButtonCellSource*)source;
@end

