//
//  MessagesUserListCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MessagesUserListCell.h"
#import "AppUtils.h"
#import "UIButton+InfoObject.h"

@implementation MessagesUserListCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"MessagesUserListCell";
        self.staticHeightForCell = 85;
    }
    return self;
}

@end


@implementation MessagesUserListCell

- (void)setUpWithSource:(MessagesUserListCellSource*)source
{
   
    
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    _tapGesture.infoObject = source.messageListItem;
    
    
    _userNameLabel.text = source.messageListItem.partnerName;
    _messageLabel.text = source.messageListItem.lastMessage.text;
    _timeLabel.text = source.messageListItem.lastMessage.time;
    
    NSInteger  unreadMessagesCount = source.messageListItem.lastMessage.unreadMessagesCount;
    _unreadMessagesCountLabel.alpha = unreadMessagesCount;
    _unreadMessagesCountLabel.text = [NSString stringWithFormat:@"%ld",unreadMessagesCount];
    
    CGPoint center = _unreadMessagesCountLabel.center;
    [_unreadMessagesCountLabel sizeToFit];
    
    CGRect rect = _unreadMessagesCountLabel.frame;
    rect.size.height = rect.size.height < 22 ? 22 : rect.size.height;
    rect.size.width = rect.size.width < rect.size.height ? rect.size.height : rect.size.width;
    
    _unreadMessagesCountLabel.frame = rect;
    _unreadMessagesCountLabel.center = center;
    _unreadMessagesCountLabel.layer.cornerRadius = _unreadMessagesCountLabel.frame.size.height / 2.0f;
    _unreadMessagesCountLabel.clipsToBounds = YES;
    
    
    NSString * imageName = [@"radioButton" stringByAppendingFormat:@"%d",source.messageListItem.isSelected];
    _radioImage.image = [UIImage imageNamed:imageName];
    
    
    
    
    rect = _backView.frame;
    
    rect.origin.x = source.isEditing ? 45 : 0;
    rect.size.width = self.frame.size.width - rect.origin.x;
  
    
    [UIView animateWithDuration:0.5 animations:^{
        _radioImage.alpha = source.isEditing;
        _backView.frame = rect;
    }];
    
}

@end




