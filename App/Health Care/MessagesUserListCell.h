//
//  MessagesUserListCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "AppConstants.h"
#import "MessageListItem.h"
#import "UIGestureRecognizer+InfoObject.h"

@interface MessagesUserListCellSource : IDDCellSource
@property (nonatomic,retain) MessageListItem * messageListItem;
@property (nonatomic,assign) BOOL isEditing;
@end

@interface MessagesUserListCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *radioImage;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;
@property (weak, nonatomic) IBOutlet UILabel *unreadMessagesCountLabel;

- (void)setUpWithSource:(MessagesUserListCellSource*)source;
@end

