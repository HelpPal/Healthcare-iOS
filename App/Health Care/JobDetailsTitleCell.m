//
//  JobDetailsTitleCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "JobDetailsTitleCell.h"
#import "AppUtils.h"
#import "AppConstants.h"
#import "DataLoader.h"
@implementation JobDetailsTitleCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"JobDetailsTitleCell";

    }
    return self;
}

@end


@implementation JobDetailsTitleCell

- (void)setUpWithSource:(JobDetailsTitleCellSource*)source
{
    
    _userID = source.job.jobId;
    _myUserID = source.userID;
    
    
    _starRatingView.value = source.job.myRating;
    
    _titleLabel.text = source.job.title;
    _addressLabel.text =  source.job.location.address.length ? source.job.location.address : [source.job.location.city stringByAppendingFormat:@", %@",source.job.location.country];
    _distanceLabel.text = [@"" stringByAppendingFormat:@"%@    ",source.job.distance];
    
    _distanceLabel.layer.cornerRadius = 11.0f;
    _distanceLabel.clipsToBounds = YES;
}
- (IBAction)applyUserRating:(HCSStarRatingView*)sender {
    

    [DataLoader rateUser:_userID  userID:_myUserID type:@"1" rating:sender.value success:^(id responseObject) {
        
        
    } fail:^(NSError *error) {
        
    }];
}

@end




