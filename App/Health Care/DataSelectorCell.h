//
//  DataSelectorCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "UIGestureRecognizer+InfoObject.h"
#import "CustomInputView.h"



@interface DataSelectorCellSource : IDDCellSource
@property (retain, nonatomic)  NSString *buttonTitle;

//update
@property (nonatomic,strong) NSString *inputText;
@property (nonatomic,assign) int textFieldTag;
@property (nonatomic,assign) BOOL isMapType;
//

@property (nonatomic,assign) BOOL enabled;
@end

@interface DataSelectorCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;
@property (weak, nonatomic) IBOutlet CustomInputView *inputView;

//update
@property (nonatomic,strong) DataSelectorCellSource *source;
//


- (void)setUpWithSource:(DataSelectorCellSource*)source;
@end

