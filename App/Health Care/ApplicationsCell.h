//
//  ApplicationsCell.h
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


@interface ApplicationsCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic, strong) ApplicationItem *applicationItem;
@property (nonatomic,assign) SEL declineSelector;
@property (nonatomic,assign) SEL sendMessageSelector;
@property (nonatomic,assign) SEL optionsSelector;
@property (nonatomic,assign) SEL declinedOptionsSelector;
@property (nonatomic,assign) SEL waitingOptionsSelector;
@property (nonatomic,assign) SEL showJobDetailsSelector;

@end

@interface ApplicationsCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *allStatesButton;
@property (weak, nonatomic) IBOutlet UIImageView *separatorsImage;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIView *segmentBackView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet MultiSelectSegmentedControl *daysSegmentedControll;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressTrailing;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;

- (void)setUpWithSource:(ApplicationsCellSource*)source;
@end

