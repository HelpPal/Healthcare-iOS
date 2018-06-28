//
//  LostPasswordViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "LostPasswordViewController.h"

@interface LostPasswordViewController ()
@property (weak, nonatomic) IBOutlet CustomInputView *emailInputView;

@end

@implementation LostPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _emailInputView.textField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)recoverPassord:(UIButton *)sender {
    
    NSString *messsageString = @"";
    
    if ([AppUtils isEmailValid:_emailInputView.textField.text] == NO) {
        messsageString = @"Invalid email adddress";
    }
    
    if (messsageString.length) {
        
        NSError *error = [NSError errorWithDomain:appErrorDomain code:0 userInfo:@{@"message" : messsageString}];
        [DataLoader alertUserForError:error];
        return;
    }
    
   [DataLoader recoverUserPasswordForEmail:_emailInputView.textField.text success:^(id responseObject) {
       [self performSegueWithIdentifier:segue_showLostPasswordInstructions sender:nil];
   } fail:^(NSError *error) {
       
   }];
}

#pragma mark - Hide Keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self recoverPassord:0];
    return NO;
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
