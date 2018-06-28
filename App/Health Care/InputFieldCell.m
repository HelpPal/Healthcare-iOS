//
//  InputFieldCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "InputFieldCell.h"
#import "AppUtils.h"

@implementation InputFieldCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"InputFieldCell";
      self.staticHeightForCell = 53;
      self.keyboardType = UIKeyboardTypeDefault;
  }
  return self;
}

@end


@implementation InputFieldCell

- (void)setUpWithSource:(InputFieldCellSource*)source
{
    _source = source;
    NSString * imageName = @"";
    
    switch (source.inputType) {
        case _keyForm:
            imageName = @"passwordKeyImage";
            break;
        case _userForm:
            imageName = @"userFormImage";
            break;
        default:
            break;
    }
    
    
    
    //update
    if (source.enableUpperCase == YES)
        _inputView.textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    //
    
    
    
    _inputView.textField.keyboardType = source.keyboardType;
    _inputView.image.image = imageName.length ? [UIImage imageNamed:imageName] : nil;
    
    _textFieldLeftSpace.constant = (_inputView.image.image == nil) ?  _inputView.image.frame.origin.x + 5 :  _inputView.image.frame.origin.x + _inputView.image.frame.size.width;

    _inputView.textField.secureTextEntry = (source.inputType == _keyForm );
    _inputView.textField.placeholder = source.placeholder;
    UIColor *color = [AppUtils placeholdersColor];
    if (source.placeholder.length) {
        _inputView.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_inputView.textField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    _inputView.textField.tag = source.textFieldTag;
    _inputView.textField.text = source.inputText;
    [_inputView.textField removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_inputView.textField addTarget:source.target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [_inputView.textField removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
    [_inputView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _inputView.textField.delegate = source.target;
}

- (void)textFieldDidChange:(UITextField *)textField
{

    _source.inputText = textField.text;

}

@end




