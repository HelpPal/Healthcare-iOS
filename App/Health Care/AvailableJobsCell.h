//
//  AvailableJobsCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "MultiSelectSegmentedControl.h"
#import "Job.h"
#import "HCSStarRatingView.h"
#import "UIGestureRecognizer+InfoObject.h"
@interface AvailableJobsCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) Job * job;

@end

@interface AvailableJobsCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;
@property (weak, nonatomic) IBOutlet UIView *segmentBackView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet MultiSelectSegmentedControl *daysSegmentedControll;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressWidth;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressTrailing;

- (void)setUpWithSource:(AvailableJobsCellSource*)source;
@end

