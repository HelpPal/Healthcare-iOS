//
//  CustomButtonCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "RoundedCorrnersButton.h"

@interface CustomButtonCellSource : IDDCellSource
@property (retain, nonatomic)  NSString *buttonTitle;
@property (nonatomic,assign) SEL buttonSelector;
@end

@interface CustomButtonCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet RoundedCorrnersButton *blueButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonConstraintWidth;

- (void)setUpWithSource:(CustomButtonCellSource*)source;
@end

