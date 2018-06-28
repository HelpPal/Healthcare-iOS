//
//  JobDetailsDaysAndPriceCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "JobDetailsDaysAndPriceCell.h"
#import "AppUtils.h"
#import "AppConstants.h"

@implementation JobDetailsDaysAndPriceCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"JobDetailsDaysAndPriceCell";

    }
    return self;
}

@end


@implementation JobDetailsDaysAndPriceCell

- (void)setUpWithSource:(JobDetailsDaysAndPriceCellSource*)source
{
    _segmentBackView.layer.cornerRadius = _daysSegmentedControll.frame.size.height/2.0;
    _segmentBackView.layer.borderColor = self.backgroundColor.CGColor;
    _segmentBackView.layer.borderWidth = 1.0;
    
    _segmentBackView.clipsToBounds = YES;
    
    [_daysSegmentedControll setTitleTextAttributes:@{NSForegroundColorAttributeName:[AppUtils inputFieldTextColor],
                                                     NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:16]}
                                          forState:UIControlStateNormal];
    
    
    [_daysSegmentedControll selectAllSegments:YES];
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet new] initWithIndexSet:_daysSegmentedControll.selectedSegmentIndexes];
    
    
    
    [source.job.days enumerateObjectsUsingBlock:^(Day* day, NSUInteger idx, BOOL * _Nonnull stop) {
        [indexSet removeIndex:[day.day integerValue]];
    }];
    [_daysSegmentedControll selectAllSegments:NO];
    _daysSegmentedControll.selectedSegmentIndexes = indexSet;
    
    
    _subtitleLabel.text = source.job.time_desc;
    
    _backImageView.layer.borderColor = [AppUtils separatorsColor].CGColor;
    _backImageView.layer.borderWidth = 0.5f;
    
    NSString * availableTimeString = (source.job.avalable == _fullTime) ? @"\nFull time" : @"\nPart time";
    
    NSString *priceRangeString = [NSString stringWithFormat:@"%@$ - %@$/h", source.job.min_price, source.job.max_price];
    
    if ([source.job.min_price isEqualToString:source.job.max_price]) {
        priceRangeString = [NSString stringWithFormat:@"%@$/h", source.job.min_price];
    }
    NSString *priceLabelText = [priceRangeString stringByAppendingFormat:@"%@", availableTimeString];
    
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:priceLabelText];
    
    UIFont *availableTimeFont = [UIFont fontWithName:_lato_font_regular size:16];
    
    NSRange availableTimeRange = [priceLabelText rangeOfString:availableTimeString];
    
    [attributedText addAttribute:NSFontAttributeName value:availableTimeFont range: availableTimeRange];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[AppUtils grayTextColor] range:availableTimeRange];
    
    _priceLabel.attributedText = attributedText;
}
@end




