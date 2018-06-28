//
//  JobDetailsSendMessageCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "RoundedCorrnersButton.h"
#import "User.h"

@interface JobDetailsSendMessageCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic, strong) NSString *placeholderString;

@end

@interface JobDetailsSendMessageCell : ImoDynamicDefaultCellExtended <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *paceholderLabel;
@property (nonatomic,strong)  JobDetailsSendMessageCellSource *source;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet RoundedCorrnersButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
- (void)setUpWithSource:(JobDetailsSendMessageCellSource*)source;
@end

