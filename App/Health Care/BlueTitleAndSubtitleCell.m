//
//  BlueTitleAndSubtitleCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "BlueTitleAndSubtitleCell.h"
#import "AppConstants.h"

@implementation BlueTitleAndSubtitleCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"BlueTitleAndSubtitleCell";
  }
  return self;
}

@end


@implementation BlueTitleAndSubtitleCell

- (void)setUpWithSource:(BlueTitleAndSubtitleCellSource*)source
{
    NSString *allText = [source.title stringByAppendingFormat:@"\n%@",source.subtitle];
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:allText];
    
    UIFont *subtitleFont = [UIFont fontWithName:_lato_font_regular size:18];
    NSRange subtitleRange = [allText rangeOfString:[@"\n" stringByAppendingString:source.subtitle]];
    [attributedText addAttribute:NSFontAttributeName value:subtitleFont range: subtitleRange];
    
    
    // update
    UIFont *titleFont = [UIFont fontWithName:_lato_font_bold size:22];
    NSRange titleRange = NSMakeRange(0, source.title.length);
    [attributedText addAttribute:NSFontAttributeName value:titleFont range: titleRange];

    
    NSString *preTitleString = [[source.title componentsSeparatedByString:@"\r"] objectAtIndex:0];
    UIFont *preTitleFont = [UIFont fontWithName:_lato_font_bold size:26];
    NSRange preTitleRange = NSMakeRange(0, preTitleString.length);
    [attributedText addAttribute:NSFontAttributeName value:preTitleFont range: preTitleRange];
    
    _titleAndSubtitleLabel.attributedText = attributedText;
    //
    
    
    // default
//    NSString *allText = [source.title stringByAppendingFormat:@"\n%@",source.subtitle];
//    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:allText];
//
//    UIFont *subtitleFont = [UIFont fontWithName:_lato_font_regular size:18];
//
//    NSRange subtitleRange = [allText rangeOfString:[@"\n" stringByAppendingString:source.subtitle]];
//
//    [attributedText addAttribute:NSFontAttributeName value:subtitleFont range: subtitleRange];
//    _titleAndSubtitleLabel.attributedText = attributedText;
}

@end




