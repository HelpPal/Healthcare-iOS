//
//  SliderCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import <MARKRangeSlider/MARKRangeSlider.h>
#import "AppConstants.h"
@interface SliderCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,assign) NSInteger minimumValue;
@property (nonatomic,assign) NSInteger maximumValue;
@property (nonatomic,assign) NSInteger leftValue;
@property (nonatomic,assign) NSInteger rightValue;
@property (nonatomic,assign) NSString* currencyString;
@property (nonatomic,assign) SliderType sliderType;
@end

@interface SliderCell : ImoDynamicDefaultCellExtended
@property (strong, nonatomic) SliderCellSource *source;
@property (weak, nonatomic) IBOutlet UILabel *maximumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *minimumLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (retain, nonatomic)  MARKRangeSlider *rangeSlider;
- (void)setUpWithSource:(SliderCellSource*)source;
@end

