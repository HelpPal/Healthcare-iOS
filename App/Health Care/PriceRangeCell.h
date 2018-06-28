//
//  PriceRangeCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "CustomInputView.h"

@interface PriceRangeCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,assign) NSInteger  minPriceTag;
@property (nonatomic,assign) NSInteger  maxPriceTag;
@property (nonatomic,strong) NSString  *maxPriceString;
@property (nonatomic,strong) NSString  *minPriceString;

@end

@interface PriceRangeCell : ImoDynamicDefaultCellExtended
@property (nonatomic,strong) PriceRangeCellSource *source;
@property (weak, nonatomic) IBOutlet CustomInputView *maxPriceInputView;
@property (weak, nonatomic) IBOutlet CustomInputView *minPriceInputView;
- (void)setUpWithSource:(PriceRangeCellSource*)source;

@end

