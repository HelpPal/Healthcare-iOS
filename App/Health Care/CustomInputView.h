//
//  CustomInputView.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomInputView : UIView 

@property (nonatomic,weak) IBOutlet UIImageView * image;
@property (nonatomic,weak) IBOutlet UITextField * textField;
@end

typedef enum {
    _defaultt,
    _keyForm,
    _userForm
} InputType;
