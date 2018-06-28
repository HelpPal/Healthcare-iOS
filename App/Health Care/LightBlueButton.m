//
//  LightBlueButton.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "LightBlueButton.h"
#import "AppConstants.h"
#import "AppUtils.h"
@implementation LightBlueButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [AppUtils buttonBlueColor];
        self.titleLabel.font = [UIFont fontWithName: _lato_font_regular  size:18];
        [self setTitleColor:[AppUtils buttonRedTextColor] forState: UIControlStateHighlighted];
        [self setTitleColor:[AppUtils buttonRedTextColor] forState: UIControlStateSelected];
        [self setTitleColor:[AppUtils buttonRedTextColor] forState: UIControlStateNormal];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    self.layer.cornerRadius = rect.size.height * 19.0 / 52.0;
    self.clipsToBounds = YES;
    
    }

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [AppUtils buttonBlueColor].CGColor;

    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.backgroundColor = [AppUtils lightBlueColor];
    self.layer.borderWidth = 0.0;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.backgroundColor = [AppUtils buttonBlueColor];
    self.layer.borderWidth = 0.0;
}



@end
