//
//  AcceptDeclineCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "ApplicationItem.h"

@interface AcceptDeclineCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic, strong) ApplicationItem *applicationItem;
@property (nonatomic,assign) SEL declineSelector;
@property (nonatomic,assign) SEL sendMessageSelector;
@property (nonatomic,assign) SEL optionsSelector;
@property (nonatomic,assign) SEL declinedOptionsSelector;
@property (nonatomic,assign) SEL waitingOptionsSelector;

@end

@interface AcceptDeclineCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIButton *allStatesButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
- (void)setUpWithSource:(AcceptDeclineCellSource*)source;
@end

