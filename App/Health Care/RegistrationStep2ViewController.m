//
//  RegistrationStep2ViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "RegistrationStep2ViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "BlueButtonRoundedCell.h"
#import "InputFieldCell.h"
#import "RegistrationStep3ViewController.h"


@interface RegistrationStep2ViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *repeatPassword;
@end

@implementation RegistrationStep2ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self buildInterface];
    
    // Do any additional setup after loading the view.
}


-(void)buildInterface
{
    _password = @"";
    _repeatPassword = @"";
    
    NSMutableArray *section = [NSMutableArray new];
   
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    //Title and subtitle Cell
    {
        BlueTitleAndSubtitleCellSource *cellSource = [BlueTitleAndSubtitleCellSource new];
        cellSource.title = @"Registration: Step 2";
        cellSource.subtitle = @"Login information";
        [section addObject:cellSource];
    }
    
    // Input fields
    
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    
    NSArray *placeholders = @[ @"Email" , @"Password", @"Repeat password"];
    for (int i = 0; i < placeholders.count; i++)
    {
        {
            InputFieldCellSource *cellSource = [InputFieldCellSource new];
            cellSource.inputType = (i == 0) ? _userForm : _keyForm;
            cellSource.keyboardType = (i == 0) ? UIKeyboardTypeEmailAddress : UIKeyboardTypeDefault;
            cellSource.placeholder = placeholders[i];
            cellSource.textFieldTag = i;
            cellSource.target = self;
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 10;
            [section addObject:cellSource];
        }
    }
     
  
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 45;
        [section addObject:cellSource];
    }
    
    // next button
    {
        BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
        cellSource.buttonTitle =  @"Next step";
        cellSource.padding = 105;
        cellSource.selector = @selector(nextStep:);
        [section addObject:cellSource];
    }
    
   
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 15;
        [section addObject:cellSource];
    }
  
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];

    
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
 textField.returnKeyType = UIReturnKeyDone;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self nextStep:nil];
    return NO;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    //ewe
    NSInteger tag = textField.tag;
    
    switch (tag) {
        case 0:
            self.user.email = textField.text;
            break;
        case 1:
            _password = textField.text;
            
            break;
        case 2:
            _repeatPassword = textField.text;
            break;
            
        default:
            break;
    }
}

-(IBAction)nextStep:(id)sender
{
    
    NSString *messsageString = @"";
    
    
    if (_password.length < 6) {
        messsageString = @"Password must have at least 6 characters";
    }
    
    else if ([AppUtils isEmailValid:self.user.email] == NO) {
        messsageString = @"Invalid email adddress";
    }
    
    else if ([_password isEqualToString: _repeatPassword] == NO) {
        messsageString = @"Password fields does not match";
    }
    
    if (messsageString.length) {
        
        NSError *error = [NSError errorWithDomain:appErrorDomain code:0 userInfo:@{@"message" : messsageString}];
        [DataLoader alertUserForError:error];
        return;
    }
    
    [DataLoader checkEmail:self.user.email success:^(id responseObject) {
        [self performSegueWithIdentifier:segue_showRegistrationStep_3 sender:nil];
    } fail:^(NSError *error) {
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [super prepareForSegue:segue sender:sender];
    RegistrationStep3ViewController * destination = (RegistrationStep3ViewController*)segue.destinationViewController;
    destination.password = _password;
    
       
}


@end
