//
//  MessagesConversationUserCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "Message.h"

@interface MessagesConversationUserCellSource : IDDCellSource
@property (nonatomic,strong) Message* message;;
@end

@interface MessagesConversationUserCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageLabelWidth;

@property (weak, nonatomic) IBOutlet UIImageView *borderImage;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setUpWithSource:(MessagesConversationUserCellSource*)source;
@end

