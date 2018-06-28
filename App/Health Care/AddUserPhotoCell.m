//
//  AddUserPhotoCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "AddUserPhotoCell.h"
#import "AppUtils.h"
#import "AppConstants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataLoader.h"

@implementation AddUserPhotoCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"AddUserPhotoCell";
      self.backgroundColor = [UIColor whiteColor];
      self.staticHeightForCell = 138;
  }
  return self;
}

@end


@implementation AddUserPhotoCell

- (void)setUpWithSource:(AddUserPhotoCellSource*)source
{
   
    
    if ([AppUtils isIphoneVersion:4]) {
        CGRect rect = _userImage.frame;
        rect.size = CGSizeMake(110, 110);
        _userImage.frame = rect;
        _userImage.center = CGPointMake(20 + _userImage.frame.size.width/2, self.frame.size.height/2);
    }
    
    
//    [_cameraButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
//    [_uploadButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    
    [_cameraButton addTarget:source.target action:source.takePhotoSelector forControlEvents:UIControlEventTouchUpInside];
    [_uploadButton addTarget:source.target action:source.uploadSelector forControlEvents:UIControlEventTouchUpInside];
    
    
    if(source.userURL.length > 0) {
      [_userImage sd_setImageWithURL:[NSURL URLWithString:[IMAGES_URL stringByAppendingString:source.userURL]] placeholderImage:[UIImage imageNamed:@"userProfilePhoto"]];
    } else {
    _userImage.image = source.userImage;
    }
    _userImage.layer.cornerRadius = _userImage.frame.size.width/2;
    _userImage.clipsToBounds = YES;
}


- (IBAction)uploadTouchDown:(id)sender {
    _uploadLabel.textColor = [AppUtils buttonBlueColor];
}

- (IBAction)uploadTouchUp:(id)sender {
    _uploadLabel.textColor = [UIColor darkTextColor];
}

- (IBAction)takeTouchDown:(id)sender {
    _uploadLabel.textColor = [AppUtils buttonBlueColor];
}

- (IBAction)takeTouchUp:(id)sender {
    _uploadLabel.textColor = [UIColor darkTextColor];
}

@end




