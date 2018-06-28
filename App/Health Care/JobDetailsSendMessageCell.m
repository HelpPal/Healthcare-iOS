//
//  JobDetailsSendMessageCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "JobDetailsSendMessageCell.h"
#import "DataLoader.h"
#import "UIButton+InfoObject.h"

@implementation JobDetailsSendMessageCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"JobDetailsSendMessageCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 170;
  }
  return self;
}

@end


@implementation JobDetailsSendMessageCell

- (void)setUpWithSource:(JobDetailsSendMessageCellSource*)source
{
    _source = source;
    self.backgroundColor = source.backgroundColor;
    _backView.layer.cornerRadius = 12;
    _backView.clipsToBounds = YES;
    
    _sendButton.layer.cornerRadius = 12;
    _sendButton.clipsToBounds = YES;
    
    [_sendButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_sendButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    _sendButton.infoObject = _inputTextView;
    _inputTextView.delegate = self;
    _paceholderLabel.hidden = _inputTextView.text.length;
    _paceholderLabel.text = source.placeholderString;
    
    CGRect rect = _paceholderLabel.frame;
    rect.size.width = self.frame.size.width - 65;
    _paceholderLabel.frame = rect;
    [_paceholderLabel sizeToFit];
}

- (void)textViewDidChange:(UITextView *)textView
{
    _paceholderLabel.hidden = textView.text.length;
}

@end




