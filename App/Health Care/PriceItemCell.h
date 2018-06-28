//
//  PriceItemCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface PriceItemCellSource : IDDCellSource

@property (retain, nonatomic)  NSString *price;

@end

@interface PriceItemCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSpace;

- (void)setUpWithSource:(PriceItemCellSource*)source;
@end

