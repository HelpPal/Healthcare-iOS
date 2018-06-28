//
//  MyProfileCredentialsCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "MultiSelectSegmentedControl.h"
#import "User.h"
#import "HCSStarRatingView.h"
@interface MyProfileCredentialsCellSource : IDDCellSource

@property (nonatomic,retain) User * user;
@property  (weak, nonatomic) NSString*myUserID;
@end

@interface MyProfileCredentialsCell : ImoDynamicDefaultCellExtended
@property BOOL changed;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *myratingview;
@property  (weak, nonatomic) NSString*userID;
@property  (weak, nonatomic) NSString*myUserID;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userImageWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceLabeWidth;
- (void)setUpWithSource:(MyProfileCredentialsCellSource*)source;
@end

