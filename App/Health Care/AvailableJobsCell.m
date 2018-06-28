//
//  AvailableJobsCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "AvailableJobsCell.h"
#import "AppUtils.h"
#import "AppConstants.h"
#import "UIButton+InfoObject.h"

@implementation AvailableJobsCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"AvailableJobsCell";

    }
    return self;
}

@end


@implementation AvailableJobsCell

- (void)setUpWithSource:(AvailableJobsCellSource*)source
{
    
    
        _starRatingView.value = source.job.userRating;
    _addressWidth.constant = self.frame.size.width - 135;
    _addressTrailing.constant = 10;
    _addressView.layer.cornerRadius = 10;
    _addressView.clipsToBounds = YES;
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
    
    _addressLabel.text = source.job.location.address.length ? source.job.location.address : [source.job.location.city stringByAppendingFormat:@", %@",source.job.location.country];
    
    
   _addressLabel.frame = CGRectMake(5, 2, _addressWidth.constant - 10, 0) ;
    _addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _addressLabel.numberOfLines = 0;
    [_addressLabel sizeToFit];
    
    _addressWidth.constant = _addressLabel.frame.size.width + 10;
    _addressHeight.constant = _addressLabel.frame.size.height + 3;
    
    _titleLabel.text = source.job.title;
    _subtitleLabel.text = source.job.time_desc;
    _descriptionLabel.text = source.job.information;
    _priceLabel.text = [NSString stringWithFormat:@"%@$ - %@$/h", source.job.min_price, source.job.max_price];
    
    if ([source.job.min_price isEqualToString:source.job.max_price]) {
    _priceLabel.text = [NSString stringWithFormat:@"%@$/h", source.job.min_price];
    }
    
    

    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    _tapGesture.infoObject = source.job;
    
    [self layoutSubviews];
}

@end




