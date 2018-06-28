//
//  ProfileExperienceAndPriceRangeCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "ProfileExperienceAndPriceRangeCell.h"
#import "AppUtils.h"

@implementation ProfileExperienceAndPriceRangeCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"ProfileExperienceAndPriceRangeCell";
        self.staticHeightForCell = 100;
    }
    return self;
}

@end


@implementation ProfileExperienceAndPriceRangeCell

- (void)setUpWithSource:(ProfileExperienceAndPriceRangeCellSource*)source
{
    _experienceLabel.text = [[AppUtils experienceArray][[source.user.experience intValue]] stringByAppendingString:@"\nexperience"];
    
    NSString * availableTimeString = (source.user.available == _fullTime) ? @"\nFull time" : @"\nPart time";
  
    NSString *priceRangeString = [NSString stringWithFormat:@"%@$ - %@$/h", source.user.price_min, source.user.price_max];
    
    if ([source.user.price_min isEqualToString:source.user.price_max]) {
        priceRangeString = [NSString stringWithFormat:@"%@$/h", source.user.price_min];
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




