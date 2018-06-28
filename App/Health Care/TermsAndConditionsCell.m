//
//  TermsAndConditionsCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "TermsAndConditionsCell.h"
#import "AppConstants.h"
#import "AppUtils.h"

@implementation TermsAndConditionsCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"TermsAndConditionsCell";
  }
  return self;
}

@end


@implementation TermsAndConditionsCell

- (void)setUpWithSource:(TermsAndConditionsCellSource*)source
{
    [_acceptButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_termsAndCondButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    
    [_acceptButton addTarget:source.target action:source.selector forControlEvents:UIControlEventTouchUpInside];
    [_termsAndCondButton addTarget:source.target action:source.readTermsAndConditionsSelector forControlEvents:UIControlEventTouchUpInside];
    
    NSString * imageName = [@"checkBoxImage" stringByAppendingFormat:@"%d",source.didAgreeTermsAndConditions];
    _checkBoxImage.image = [UIImage imageNamed:imageName];
    
    
    _titleAndSubtitleLabel.text = @"I have read the agree with the price and";
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:_termsAndCondLabel.text];
    [attributedText addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, _termsAndCondLabel.text.length)];
    _termsAndCondLabel.attributedText = attributedText;
}

@end




