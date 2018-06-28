//
//  DoubleMenuButton.h
//  Health Care
//
//  Created by 1 on 12/10/2016.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubleMenuButton : UIView

@property (nonatomic,weak) IBOutlet UIButton * leftButton;
@property (nonatomic,weak) IBOutlet UIButton * rightButton;
@property (nonatomic,weak) IBOutlet UIImageView * leftImage;
@property (nonatomic,weak) IBOutlet UIImageView * rightImage;

-(IBAction)changeStateForButton:(UIButton*)sender;
@end
