//
//  SliderCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "SliderCell.h"
#import "AppUtils.h"



@implementation SliderCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"SliderCell";
        self.backgroundColor = [UIColor whiteColor];
        self.staticHeightForCell = 102;
        self.multipleSelection = YES;
    }
    return self;
}

@end


@implementation SliderCell

- (void)setUpWithSource:(SliderCellSource*)source
{
    _source = source;
    _backImage.layer.borderWidth = 1.0;
    _backImage.layer.borderColor = [AppUtils separatorsColor].CGColor;
    _backImage.clipsToBounds = YES;
    [self setUpViewComponents];
}


- (IBAction)sliderValueChanged:(UISlider *)sender
{
    CGRect trackRect = [sender trackRectForBounds:sender.bounds];
    CGRect thumbRect = [sender thumbRectForBounds:sender.bounds
                                        trackRect:trackRect
                                            value:sender.value];
    
    UILabel *label = sender == _slider ? _maximumLabel : _minimumLabel;
    label.center = CGPointMake(thumbRect.origin.x  + thumbRect.size.width / 2 + sender.frame.origin.x,  sender.frame.origin.y - 15);
    
    
    if (sender.value == sender.maximumValue) {
        label.text = [@">" stringByAppendingFormat:@"%@%d",_source.currencyString,(int)sender.value - 1];
    }
    
    else
    {
        label.text = [@"" stringByAppendingFormat:@"%@%d",_source.currencyString,(int)sender.value];
    }
    
    _slider.minimumValue = _slider2.value;
    _slider2.maximumValue = _slider.value;
    
  
    [self setUpViewComponents];
}

#pragma mark - Actions

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider
{
    _minimumLabel.center = CGPointMake(slider.leftThumbView.frame.origin.x  + slider.leftThumbView.frame.size.width / 2 + slider.frame.origin.x,  slider.frame.origin.y - 15);
    _maximumLabel.center = CGPointMake(slider.rightThumbView.frame.origin.x  + slider.rightThumbView.frame.size.width / 2 + slider.frame.origin.x,  slider.frame.origin.y - 15);
   _maximumLabel.text = [@"" stringByAppendingFormat:@"%@%d",_source.currencyString,(int)slider.rightValue];
    _minimumLabel.text = [@"" stringByAppendingFormat:@"%@%d",_source.currencyString,(int)slider.leftValue];

    if (_source.sliderType > 1 ) {
        NSLog(@"slider type not set");
    }
    
    else if (_source.sliderType == _experience_time) {
        [Storage setSearchSettingsMaxExperience:_rangeSlider.rightValue];
        [Storage setSearchSettingsMinExperience:_rangeSlider.leftValue];
    }
    
    else if (_source.sliderType == _price_range) {
        [Storage setSearchSettingsMaxPriceRange:_rangeSlider.rightValue];
        [Storage setSearchSettingsMinPriceRange:_rangeSlider.leftValue];
    }
}

#pragma mark - UI


- (void)setUpViewComponents
{
    [_rangeSlider removeFromSuperview];
    _rangeSlider = nil;
    
    _rangeSlider = [[MARKRangeSlider alloc] initWithFrame:_slider.frame];
    _rangeSlider.autoresizingMask = _slider.autoresizingMask;
    
    [_rangeSlider setMinValue:_source.minimumValue maxValue:_source.maximumValue];
    [_rangeSlider setLeftValue:_source.leftValue rightValue:_source.rightValue];
    _rangeSlider.leftThumbImage = [UIImage imageNamed:@"sliderThumbImage"];
    _rangeSlider.rightThumbImage = [UIImage imageNamed:@"sliderThumbImage"];
    _rangeSlider.rangeImage = [UIImage imageNamed:@"sliderRangeImage"];
    _rangeSlider.trackImage = [UIImage imageNamed:@"sliderMarginsImage"];
    [_rangeSlider addTarget:self action:@selector(rangeSliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    _rangeSlider.minimumDistance = 0;
    [self addSubview:_rangeSlider];
    [_rangeSlider layoutSubviews];
    [self rangeSliderValueDidChange:_rangeSlider];
    
}



@end




