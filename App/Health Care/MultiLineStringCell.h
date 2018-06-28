//
//  MultiLineStringCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface MultiLineStringCellSource : IDDCellSource

@property (retain, nonatomic)  NSString *infoText;
@property (assign, nonatomic)  float fontSize;
@property (assign, nonatomic)  NSTextAlignment textAlignment;
@property (nonatomic, retain)  UIColor *textColor;
@property (nonatomic, retain)  UIColor *backgroundColor;
@end

@interface MultiLineStringCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


- (void)setUpWithSource:(MultiLineStringCellSource*)source;
@end

