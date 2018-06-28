//
//  SpaceCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface SpaceCellSource : IDDCellSource
@property (nonatomic,retain) UIColor * backgroundColor;
@end

@interface SpaceCell : ImoDynamicDefaultCellExtended
- (void)setUpWithSource:(SpaceCellSource*)source;
@end

