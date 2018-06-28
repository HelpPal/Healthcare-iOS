//
//  ExpirationSubcribtionViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/18/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "ExpirationSubcribtionViewController.h"



@interface ExpirationSubcribtionViewController ()
@property (weak, nonatomic) IBOutlet UIView *logoutView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation ExpirationSubcribtionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _logoutView.layer.cornerRadius = _logoutView.frame.size.height /2.0;
    _logoutButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _logoutButton.layer.borderWidth = 1.0f;
    
    CGRect priceFrame = _priceLabel.frame;
    [_priceLabel sizeToFit];
    priceFrame.size.width = _priceLabel.frame.size.width + 40;
    priceFrame.origin.y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 10;
    _priceLabel.frame = priceFrame;
    _priceLabel.center = CGPointMake(_titleLabel.center.x, _priceLabel.center.y);
    _priceLabel.layer.cornerRadius = _priceLabel.frame.size.height /2.0;
    _emailLabel.text = self.user.email;
    
    
    
   
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)logout:(id)sender {
    
    [DataLoader deletePush:self.user.userId success:^(id responseObject) {
        self.user = nil;
        [self dismissViewControllerAnimated:NO completion:^{
            
            [[AppUtils topViewController].navigationController popToRootViewControllerAnimated:YES];
        }];
        
        
    } fail:^(NSError *error) {
        self.user = nil;
        [self dismissViewControllerAnimated:NO completion:^{
            
            [[AppUtils topViewController].navigationController popToRootViewControllerAnimated:YES];
        }];
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
