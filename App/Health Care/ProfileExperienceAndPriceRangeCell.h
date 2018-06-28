//
//  ProfileExperienceAndPriceRangeCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "AppConstants.h"
#import "User.h"

@interface ProfileExperienceAndPriceRangeCellSource : IDDCellSource
@property (nonatomic,retain) User * user;
@end

@interface ProfileExperienceAndPriceRangeCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
- (void)setUpWithSource:(ProfileExperienceAndPriceRangeCellSource*)source;
@end

