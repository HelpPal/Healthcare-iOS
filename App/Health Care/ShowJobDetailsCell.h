//
//  ShowJobDetailsCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "Job.h"

@interface ShowJobDetailsCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) Job * job;
@end

@interface ShowJobDetailsCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;
- (void)setUpWithSource:(ShowJobDetailsCellSource*)source;
@end

