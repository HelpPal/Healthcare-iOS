//
//  DoubleMenuButton.m
//  Health Care
//
//  Created by 1 on 12/10/2016.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "DoubleMenuButton.h"
#import "AppUtils.h"
@implementation DoubleMenuButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    self.leftImage.layer.cornerRadius = 4;
    self.leftImage.clipsToBounds = YES;
    
    self.rightImage.layer.cornerRadius = 4;
    self.rightImage.clipsToBounds = YES;
    
    self.layer.cornerRadius = 20;
    self.clipsToBounds = YES;
    
 
}



-(IBAction)changeStateForButton:(UIButton*)sender
{
    

    _rightImage.hidden = (sender == _leftButton);
    _leftImage.hidden = (sender == _rightButton);
  
    UIButton * tempButton = (sender == _leftButton) ? _rightButton : _leftButton;
    
    
    [sender setBackgroundColor:[AppUtils inputFieldTextColor]];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [tempButton setBackgroundColor:[AppUtils placeholdersColor]];
    [tempButton setTitleColor:[AppUtils inputFieldTextColor] forState:UIControlStateNormal];
   
}
@end
