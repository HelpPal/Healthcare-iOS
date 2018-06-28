//
//  RoundedCorrnersButton.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "RoundedCorrnersButton.h"
#import "AppConstants.h"
#import "AppUtils.h"
@implementation RoundedCorrnersButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.titleLabel.font = [UIFont fontWithName: _lato_font_regular  size:18];
    self.layer.cornerRadius = rect.size.height * 19.0 / 52.0;
    self.clipsToBounds = YES;
    
    }

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [AppUtils buttonBlueColor].CGColor;
    [self setTitleColor:[AppUtils buttonBlueColor] forState: UIControlStateHighlighted];
    [self setTitleColor:[AppUtils buttonBlueColor] forState: UIControlStateSelected];
    [self setTitleColor:[AppUtils buttonBlueColor] forState: UIControlStateNormal];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
   [UIView animateWithDuration:0.25 animations:^{
       
   } completion:^(BOOL finished) {
       self.backgroundColor = [AppUtils buttonBlueColor];
       self.layer.borderWidth = 0.0;
       [self setTitleColor:[UIColor whiteColor] forState: UIControlStateHighlighted];
       [self setTitleColor:[UIColor whiteColor] forState: UIControlStateSelected];
       [self setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
   }];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        self.backgroundColor = [AppUtils buttonBlueColor];
        self.layer.borderWidth = 0.0;
        [self setTitleColor:[UIColor whiteColor] forState: UIControlStateHighlighted];
        [self setTitleColor:[UIColor whiteColor] forState: UIControlStateSelected];
        [self setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    }];
}



@end
