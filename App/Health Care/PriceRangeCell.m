//
//  PriceRangeCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "PriceRangeCell.h"

@implementation PriceRangeCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"PriceRangeCell";
        self.backgroundColor = [UIColor whiteColor];
        self.staticHeightForCell = 52.0;
    }
    return self;
}

@end


@implementation PriceRangeCell

- (void)setUpWithSource:(PriceRangeCellSource*)source
{
    _source = source;
    self.backgroundColor = source.backgroundColor;
    _minPriceInputView.textField.tag = source.minPriceTag;
    _maxPriceInputView.textField.tag = source.maxPriceTag;
    
    _minPriceInputView.textField.text = source.minPriceString;
    _maxPriceInputView.textField.text = source.maxPriceString;
    
    
    _minPriceInputView.textField.delegate = source.target;
    _maxPriceInputView.textField.delegate = source.target;
    
    [_minPriceInputView.textField removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_minPriceInputView.textField addTarget:source.target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_maxPriceInputView.textField removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_maxPriceInputView.textField addTarget:source.target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_minPriceInputView.textField removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
    [_minPriceInputView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_maxPriceInputView.textField removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
    [_maxPriceInputView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField == _minPriceInputView.textField) {
        _source.minPriceString = textField.text;
    }
    
    else
    {
        _source.maxPriceString = textField.text;
        
    }
    
}


@end




