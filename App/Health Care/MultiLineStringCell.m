//
//  MultiLineStringCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MultiLineStringCell.h"
#import "AppUtils.h"
@implementation MultiLineStringCellSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellClass = @"MultiLineStringCell";
        self.textAlignment = NSTextAlignmentCenter;
        self.fontSize = 20;
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [AppUtils placeholdersColor];
    }
  return self;
}

@end


@implementation MultiLineStringCell


- (void)setUpWithSource:(MultiLineStringCellSource*)source
{
    self.backgroundColor = source.backgroundColor;
    
    if (source.textColor != nil) {
        _infoLabel.textColor = source.textColor;
    }
    _infoLabel.text = source.infoText;
    _infoLabel.font = [UIFont fontWithName:_infoLabel.font.fontName size:source.fontSize];
    _infoLabel.textAlignment = source.textAlignment;
}

@end




