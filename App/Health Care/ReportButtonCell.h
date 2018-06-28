//
//  ReportButtonCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "RoundedCorrnersButton.h"

@interface ReportButtonCellSource : IDDCellSource
@property (retain, nonatomic)  NSString *buttonTitle;
@property (nonatomic,assign) SEL buttonSelector;
@end

@interface ReportButtonCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet RoundedCorrnersButton *blueButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonConstraintWidth;

- (void)setUpWithSource:(ReportButtonCellSource*)source;
@end

