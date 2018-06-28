//
//  DataSelectorCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "DataSelectorCell.h"
#import "AppUtils.h"

@implementation DataSelectorCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"DataSelectorCell";
      self.staticHeightForCell = 66;
  }
  return self;
}

@end


@implementation DataSelectorCell

- (void)setUpWithSource:(DataSelectorCellSource*)source
{
    
    self.selected = source.selected;
    
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        if (source.isMapType) {
            [_inputView.image addGestureRecognizer:_tapGesture];
        }
        else {
            [self addGestureRecognizer:_tapGesture];
        }
        
        
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    
    _titleLabel.text = source.buttonTitle;
    UIColor *textColor = source.enabled ? [AppUtils inputFieldTextColor] : [AppUtils placeholdersColor];
    
    _titleLabel.textColor = textColor;
    
    
    
    
    
    
    
    
    
//    self.selected = source.selected;
//
//    if ([AppUtils isValidObject:_tapGesture] == NO) {
//        _tapGesture = [UITapGestureRecognizer new];
//
//        [self addGestureRecognizer:_tapGesture];
//    }
//
//    [_tapGesture removeTarget:source.target action:NULL];
//    [_tapGesture addTarget:source.target action:source.selector];
//
//    _titleLabel.text = source.buttonTitle;
//    UIColor *textColor = source.enabled ? [AppUtils inputFieldTextColor] : [AppUtils placeholdersColor];
//
//    _titleLabel.textColor = textColor;
    
    if (source.isMapType) {
        _inputView.image.image = [UIImage imageNamed:@"pin"];
    } else {
        _inputView.textField.hidden = YES;
        _inputView.image.image = [UIImage imageNamed:@"dataSelectorArrow"];
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




