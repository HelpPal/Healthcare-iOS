//
//  AddUserPhotoCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface AddUserPhotoCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic,assign) SEL uploadSelector;
@property (nonatomic,assign) SEL takePhotoSelector;
@property (nonatomic,retain) UIImage* userImage;
@property (nonatomic,retain) NSString* userURL;
@end

@interface AddUserPhotoCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UILabel *uploadLabel;
- (void)setUpWithSource:(AddUserPhotoCellSource*)source;
@end

