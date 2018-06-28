//
//  TaggedStringCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import <SKTagView/SKTagView.h>
#import "User.h"
#import "UIGestureRecognizer+InfoObject.h"


@interface TaggedStringCellSource : IDDCellSource
@property (nonatomic,retain) User *user;
@property (nonatomic,retain) UIColor * backgroundColor;
@property (nonatomic, assign) BOOL showAllTags;
@end

@interface TaggedStringCell : ImoDynamicDefaultCellExtended
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;

@property (weak, nonatomic) IBOutlet SKTagView *tagView;
- (void)setUpWithSource:(TaggedStringCellSource*)source;

@end

