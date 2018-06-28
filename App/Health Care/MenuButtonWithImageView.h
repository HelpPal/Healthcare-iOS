//
//  MenuButtonWithImageView.h
//  Health Care
//
//  Created by 1 on 12/10/2016.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButtonWithImageView : UIView
@property (nonatomic,weak) IBOutlet UIImageView * image;
@property (nonatomic,weak) IBOutlet UIButton * button;
@property (nonatomic,weak) IBOutlet UILabel * titleLebel;

-(void)setButtonImage:(NSString*)imageName;

@end
