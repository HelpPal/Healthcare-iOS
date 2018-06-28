//
//  JobDetailsTitleCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "MultiSelectSegmentedControl.h"
#import "Job.h"
#import "HCSStarRatingView.h"
@interface JobDetailsTitleCellSource : IDDCellSource

@property (nonatomic, strong) Job *job;
@property (nonatomic, strong) NSString *userID;
@end

@interface JobDetailsTitleCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *myUserID;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceLabeWidth;
- (void)setUpWithSource:(JobDetailsTitleCellSource*)source;
@end

