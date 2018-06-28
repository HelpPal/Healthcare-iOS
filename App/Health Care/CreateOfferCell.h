//
//  CreateOfferCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface CreateOfferCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface CreateOfferCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;
- (void)setUpWithSource:(CreateOfferCellSource*)source;
@end

