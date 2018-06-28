//
//  CertifiedNursingAssistantsListCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "CertifiedNursingAssistantsListCell.h"
#import "AppUtils.h"
#import "AppConstants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataLoader.h"
#import "AppUtils.h"

@implementation CertifiedNursingAssistantsListCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"CertifiedNursingAssistantsListCell";
        
    }
    return self;
}

@end


@implementation CertifiedNursingAssistantsListCell

- (void)setUpWithSource:(CertifiedNursingAssistantsListCellSource*)source
{
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
                       
         [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    _tapGesture.infoObject = source.user;

    _nameLabel.text = source.user.fullName;
    _detailsLabel.text = source.user.userDescriptionDetails;
    _distanceLabel.text = [@"" stringByAppendingFormat:@"%@mi    ",source.user.distance];
    _addressLabel.text = source.user.location.address;
 
    

     [_starRatingView setValue:source.user.userRating];
  
    
    _starRatingView.userInteractionEnabled = false;
   // _starRatingView.value = source.user.userRating;
   // [_starRatingView setValue:source.user.userRating];
    _distanceLabel.layer.cornerRadius = 11.0f;
    _distanceLabel.clipsToBounds = YES;
    
    _userPhoto.layer.cornerRadius = _userImageWidth.constant/2.0f;
    _userPhoto.clipsToBounds = YES;
    
    
    [_userPhoto sd_setImageWithURL:[NSURL URLWithString:[IMAGES_URL stringByAppendingString:source.user.profile_img]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) {
            _userPhoto.image = [UIImage imageNamed:@"userProfilePhoto"];
        }
    }];
    
    _priceLabel.text = [NSString stringWithFormat:@"%@$ - %@$/h", source.user.price_min, source.user.price_max];
    
    if ([source.user.price_min isEqualToString:source.user.price_max])
    {
        _priceLabel.text = [NSString stringWithFormat:@"%@$/h", source.user.price_min];
    }


    
    NSString * availableTimeString = (source.user.available_time == _fullTime) ? @"\nFull time" : @"\nPart time";
    NSString *priceLabelText = [_priceLabel.text stringByAppendingFormat:@"%@", availableTimeString];
    
    
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:priceLabelText];
    
    UIFont *availableTimeFont = [UIFont fontWithName:_lato_font_regular size:16];
    
    NSRange availableTimeRange = [priceLabelText rangeOfString:availableTimeString];
    
    [attributedText addAttribute:NSFontAttributeName value:availableTimeFont range: availableTimeRange];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[AppUtils grayTextColor] range:availableTimeRange];
    
    _priceLabel.attributedText = attributedText;

}

@end




