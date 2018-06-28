//
//  UserDescribtionInputViewCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "User.h"

@interface UserDescribtionInputViewCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,retain) User * user;
@end

@interface UserDescribtionInputViewCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
- (void)setUpWithSource:(UserDescribtionInputViewCellSource*)source;
@end

