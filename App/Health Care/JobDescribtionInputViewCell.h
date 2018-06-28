//
//  JobDescribtionInputViewCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "Job.h"

@interface JobDescribtionInputViewCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) Job * job;
@end

@interface JobDescribtionInputViewCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
- (void)setUpWithSource:(JobDescribtionInputViewCellSource*)source;
@end

