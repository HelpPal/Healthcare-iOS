//
//  CertifiedNursingAssistantsListCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "MultiSelectSegmentedControl.h"
#import "AppConstants.h"
#import "ApplicationItem.h"
#import "UIGestureRecognizer+InfoObject.h"
#import "HCSStarRatingView.h"
@interface CertifiedNursingAssistantsListCellSource : IDDCellSource

@property (nonatomic,strong) User* user;


@end

@interface CertifiedNursingAssistantsListCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userImageWidth;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;

- (void)setUpWithSource:(CertifiedNursingAssistantsListCellSource*)source;
@end

