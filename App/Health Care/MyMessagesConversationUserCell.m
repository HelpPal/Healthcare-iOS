//
//  MyMessagesConversationUserCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MyMessagesConversationUserCell.h"
#import "AppUtils.h"

@implementation MyMessagesConversationUserCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"MyMessagesConversationUserCell";
        
    }
    return self;
}

@end


@implementation MyMessagesConversationUserCell

- (void)setUpWithSource:(MyMessagesConversationUserCellSource*)source
{

    _messageLabel.preferredMaxLayoutWidth = 300;//self.frame.size.width300;
    _messageLabel.text = source.message.text;
    _timeLabel.text = source.message.time;
    
    _borderImage.layer.borderWidth = 1.0;
    _borderImage.layer.borderColor = [AppUtils separatorsColor].CGColor;
    _borderImage.layer.cornerRadius = 12.0;
    _borderImage.clipsToBounds = YES;
    
 
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 130, 0)];
    label.numberOfLines = 0;
    label.font = _messageLabel.font;
    label.text = _messageLabel.text;
    [label sizeToFit];
   
    _messageLabelWidth.constant = label.frame.size.width;
   


}

@end




