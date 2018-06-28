//
//  CustomInputView.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "CustomInputView.h"
#import "AppUtils.h"

@implementation CustomInputView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
    
    
- (void)drawRect:(CGRect)rect {

    self.layer.cornerRadius = rect.size.height/2.0;
    self.clipsToBounds = YES;
    _textField.textColor = [AppUtils inputFieldTextColor];
    if (_textField.placeholder.length) {
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textField.placeholder attributes:@{NSForegroundColorAttributeName: [AppUtils placeholdersColor]}];
    }
    
 
}



@end
