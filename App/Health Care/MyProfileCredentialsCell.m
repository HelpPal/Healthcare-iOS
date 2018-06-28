//
//  MyProfileCredentialsCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MyProfileCredentialsCell.h"
#import "AppUtils.h"
#import "AppConstants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataLoader.h"

@implementation MyProfileCredentialsCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"MyProfileCredentialsCell";
        
    }
    return self;
}

@end


@implementation MyProfileCredentialsCell

- (void)setUpWithSource:(MyProfileCredentialsCellSource*)source
{
    
    _changed = false;
  [_myratingview setValue:0.0f];
    [_myratingview setValue:source.user.myRating];
    _userID = source.user.userId;
    _myUserID = source.myUserID;
    _nameLabel.text = source.user.fullName;
    _detailsLabel.text = [NSString stringWithFormat:@"%@, %@yo, %@, %@",source.user.gender == _female ? @"Female" : @"Male", source.user.years, source.user.location.city,source.user.location.country];
    _distanceLabel.text = [@"" stringByAppendingFormat:@"%@mi    ",source.user.distance];
    
    if([_userID isEqualToString:_myUserID])
    {
        _myratingview.hidden = true;
    } else {
        _myratingview.hidden = false;
    }
    
    _distanceLabel.layer.cornerRadius = 11.0f;
    _distanceLabel.clipsToBounds = YES;
    
    _userPhoto.layer.cornerRadius = _userImageWidth.constant/2.0f;
    _userPhoto.clipsToBounds = YES;
    
    
    [_userPhoto sd_setImageWithURL:[NSURL URLWithString:[IMAGES_URL stringByAppendingString:source.user.profile_img]] placeholderImage:[UIImage imageNamed:@"userProfilePhoto"]];
    
    _changed = true;
    
}
- (IBAction)ratingChanged:(HCSStarRatingView*)sender {
    
    if(_changed) {
    [DataLoader rateUser:_userID  userID:self.myUserID type:@"0"  rating:sender.value success:^(id responseObject) {
        
        
    } fail:^(NSError *error) {
        
    }];
    }
    
}

@end




