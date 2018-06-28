//
//  BlueTitleAndSubtitleCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface BlueTitleAndSubtitleCellSource : IDDCellSource

@property (retain, nonatomic)  NSString *subtitle;

@end

@interface BlueTitleAndSubtitleCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UILabel *titleAndSubtitleLabel;


- (void)setUpWithSource:(BlueTitleAndSubtitleCellSource*)source;
@end

