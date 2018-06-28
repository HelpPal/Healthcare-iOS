//
//  MenuButtonWithImageView.m
//  Health Care
//
//  Created by 1 on 12/10/2016.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MenuButtonWithImageView.h"
#import "AppUtils.h"


@implementation MenuButtonWithImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
       
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                _button = obj;
            }
            else if ([obj isKindOfClass:[UILabel class]]) {
                _titleLebel = obj;
            }
            else if ([obj isKindOfClass:[UIImage class]]) {
                _image = obj;
            }
        }];
        self.backgroundColor = [AppUtils buttonBlueColor];
        self.layer.cornerRadius = 20;
        self.clipsToBounds = YES;
        [self.button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [self.button addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        [self.button addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchDragOutside];
        [self.button addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchCancel];

    }
    
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    
    
  
    
    

}

-(void)touchDown:(UIButton*)sender
{
    _titleLebel.textColor = [AppUtils buttonBlueColor];
    self.backgroundColor = [UIColor whiteColor];
}


-(void)touchUp:(UIButton*)sender
{
    _titleLebel.textColor = [UIColor whiteColor];
    self.backgroundColor = [AppUtils buttonBlueColor];
}



-(void)setButtonImage:(NSString*)imageName
{
    _image.image = [UIImage imageNamed:imageName];
}


@end
