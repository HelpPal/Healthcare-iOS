//
//  JobDetailsDaysAndPriceCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "MultiSelectSegmentedControl.h"
#import "AppConstants.h"
#import "Job.h"

@interface JobDetailsDaysAndPriceCellSource : IDDCellSource
@property (nonatomic, strong) Job *job;
@end

@interface JobDetailsDaysAndPriceCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIView *segmentBackView;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet MultiSelectSegmentedControl *daysSegmentedControll;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)setUpWithSource:(JobDetailsDaysAndPriceCellSource*)source;
@end

