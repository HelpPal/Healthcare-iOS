//
//  TaggedStringCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "TaggedStringCell.h"
#import "AppUtils.h"

#import "Skill.h"

@implementation TaggedStringCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"TaggedStringCell";
      self.backgroundColor = [UIColor whiteColor];
     // self.staticHeightForCell = 200;
  }
  return self;
}

@end


@implementation TaggedStringCell

- (void)setUpWithSource:(TaggedStringCellSource*)source
{
    if ([AppUtils isValidObject:_tapGesture] == NO) {
        _tapGesture = [UITapGestureRecognizer new];
        
        [self addGestureRecognizer:_tapGesture];
    }
    
    [_tapGesture removeTarget:source.target action:NULL];
    [_tapGesture addTarget:source.target action:source.selector];
    _tapGesture.infoObject = source.user;
    
    self.backgroundColor = source.backgroundColor;
//    self.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    self.tagView.padding = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tagView.interitemSpacing = 2;
    self.tagView.lineSpacing = 5;
    
    [self.tagView removeAllTags];
    
    //Add Tags
if (source.showAllTags == NO) {
    NSString *experienceString = [AppUtils experienceArray][[source.user.experience intValue]];
    experienceString = [experienceString stringByAppendingString:@" experience:"];
    SKTag *tag = [SKTag tagWithText: experienceString];
    tag.textColor = [AppUtils grayTextColor];
    tag.fontSize = 15;
    tag.padding = UIEdgeInsetsMake(1, 5, 1, 5);
    tag.bgColor = [UIColor clearColor];
    tag.cornerRadius = 10;
    tag.enable = NO;
    [self.tagView addTag:tag];
}
    
    int count = 0;
    for (Skill *skill in source.user.skills) {
        if (count == 4 && (source.showAllTags == NO) ) {
            break;
        }
        SKTag *tag = [SKTag tagWithText:skill.name];
        tag.textColor = [UIColor whiteColor];
        tag.fontSize = 15;
        tag.padding = UIEdgeInsetsMake(1, 5, 1, 5);
        tag.bgColor = [AppUtils inputFieldTextColor];
        tag.cornerRadius = 10;
        tag.enable = NO;
        [self.tagView addTag:tag];
        count++;
    }
    
    if (source.showAllTags == NO) {
        if (count == 4 && source.user.skills.count > 4) {
            NSString *experienceString = [NSString stringWithFormat:@"%d more...",(int)source.user.skills.count - 4];
            SKTag *tag = [SKTag tagWithText: experienceString];
            tag.textColor = [AppUtils grayTextColor];
            tag.fontSize = 15;
            tag.padding = UIEdgeInsetsMake(1, 5, 1, 5);
            tag.bgColor = [UIColor clearColor];
            tag.cornerRadius = 10;
            tag.enable = NO;
            [self.tagView addTag:tag];
        }
    }
    
    
    self.tagView.backgroundColor = source.backgroundColor;
}

@end




