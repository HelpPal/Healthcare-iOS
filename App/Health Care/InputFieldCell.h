//
//  InputFieldCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "CustomInputView.h"

@interface InputFieldCellSource : IDDCellSource
@property (nonatomic,assign) InputType inputType;
@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,strong) NSString *inputText;
@property (nonatomic,assign) int textFieldTag;
@property (nonatomic,assign) UIKeyboardType keyboardType;

// update
@property (assign, nonatomic) BOOL enableUpperCase;
//

@end

@interface InputFieldCell : ImoDynamicDefaultCellExtended
@property (nonatomic,strong) InputFieldCellSource *source;
@property (weak, nonatomic) IBOutlet CustomInputView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldLeftSpace;

- (void)setUpWithSource:(InputFieldCellSource*)source;
@end

