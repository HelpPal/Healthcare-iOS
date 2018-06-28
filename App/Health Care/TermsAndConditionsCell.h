//
//  TermsAndConditionsCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>

@interface TermsAndConditionsCellSource : IDDCellSource

@property (retain, nonatomic)  NSString *subtitle;
@property (nonatomic,assign)  BOOL didAgreeTermsAndConditions;
@property (nonatomic,assign) SEL readTermsAndConditionsSelector;
@end

@interface TermsAndConditionsCell : ImoDynamicDefaultCellExtended

@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImage;
@property (weak, nonatomic) IBOutlet UILabel *titleAndSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UILabel *termsAndCondLabel;
@property (weak, nonatomic) IBOutlet UIButton *termsAndCondButton;


- (void)setUpWithSource:(TermsAndConditionsCellSource*)source;
@end

