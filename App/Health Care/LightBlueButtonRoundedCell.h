//
//  LightBlueButtonRoundedCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "RoundedCorrnersButton.h"

@interface LightBlueButtonRoundedCellSource : IDDCellSource
@property (retain, nonatomic)  NSString *buttonTitle;
@property (retain, nonatomic)  UIColor *buttonBackColor;
@property (retain, nonatomic)  UIColor *buttonTitleColor;
@property  CGFloat padding;

@end

@interface LightBlueButtonRoundedCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftPadding;
@property (weak, nonatomic) IBOutlet RoundedCorrnersButton *blueButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightPadding;

- (void)setUpWithSource:(LightBlueButtonRoundedCellSource*)source;
@end

