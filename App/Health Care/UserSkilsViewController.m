//
//  UserSkilsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "UserSkilsViewController.h"
#import "CheckBoxItemCell.h"
#import "SpaceCell.h"

#import "UIButton+InfoObject.h"

@interface UserSkilsViewController () <UITextFieldDelegate>
@property (nonatomic,strong) NSMutableSet * selectedSet;
@property (nonatomic,strong) NSMutableArray * skilsArray;

@property (nonatomic, strong) NSMutableArray * randomNumbers;
@property (weak, nonatomic) IBOutlet UITextField *inputSkillField;
@property (strong, nonatomic) NSString *skillString;
@property int lastSkillID;
@end

@implementation UserSkilsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Select your skills";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lastSkillID = 0;
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, 75, 38);
    editButton.backgroundColor = [AppUtils buttonBlueColor];
    editButton.titleLabel.font = [UIFont fontWithName:_lato_font_regular size:14];
    editButton.layer.cornerRadius = 12.0f;
    [editButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setTitle:@"Done" forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    
    self.navigationItem.rightBarButtonItem = rightButton;

    
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _randomNumbers = [NSMutableArray new];
    
    _skilsArray = [NSMutableArray new];
    _selectedSet = [NSMutableSet new];
    
    
    [self.user.skills enumerateObjectsUsingBlock:^(Skill *skill, NSUInteger idx, BOOL * _Nonnull stop) {
        [_selectedSet addObject:skill.skillId];
    }];

    [DataLoader getSkillsTermsUserID:self.user.userId succes:^(NSArray * skills) {
        
        _skilsArray = [NSMutableArray arrayWithArray:skills];
        
        for (Skill *skill in _skilsArray) {
            NSLog(@"Skill %@ id %d", skill.name, skill.skillId.integerValue);
        }
        [self buildInterface];
    } fail:^(NSError *error) {
        
    }];
    
    }

- (IBAction)addSkill:(id)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Add new skill"
                                                                              message: @""
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
       textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.placeholder = @"Name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * newSKill = textfields[0];
    
        NSLog(@"%@",newSKill.text);
        
        
        Skill *newSkill = [[Skill alloc] init];
        NSNumber *skillId = [[NSNumber alloc] init];
        
   
        skillId =[NSNumber numberWithInteger:_lastSkillID+1];
        
      
            
            if (newSKill.text.length > 0) {
                
         
                
                newSkill.skillId = skillId;
                newSkill.name = newSKill.text;
                newSkill.isOtherSkill = YES;
                
                [_skilsArray addObject:newSkill];
                [self buildInterface];
                [self scrollToBottom];
                
            } else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You must enter a skill" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                
                [alertController addAction:okAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        
        
        
    }]];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)buildInterface
{
    
    NSMutableArray *section = [NSMutableArray new];
    
    
   
    
    for (Skill * skill in _skilsArray) {
        {
            CheckBoxItemCellSource *cellSource = [CheckBoxItemCellSource new];
            cellSource.title = skill.name;
            cellSource.isSelected = [_selectedSet containsObject:skill.skillId];
            cellSource.selector = @selector(selectItem:);
            cellSource.target = self;
            cellSource.objectId = skill.skillId;
            _lastSkillID = skill.skillId;
            [section addObject:cellSource];
        }
        
        {
            SeparatorCellSource *cellSource = [SeparatorCellSource new];
            [section addObject:cellSource];
        }
    }
   
       
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
}

-(IBAction)selectItem:(UIGestureRecognizer*)sender
{
    if ([_selectedSet containsObject:sender.infoObject])
    {
        [_selectedSet removeObject:sender.infoObject];
         [self buildInterface];
        return;
    }
    
    [_selectedSet addObject:sender.infoObject];
    [self buildInterface];
}

-(IBAction)pressDoneButton:(id)sender
{
    [self.user.skills removeAllObjects];
    for (Skill * skill in _skilsArray)
    {
        
        if ([_selectedSet containsObject:skill.skillId]) {
            [self.user.skills addObject:skill];
      //  if ([_selectedSet containsObject:skill.skillId] && !skill.isOtherSkill) {
        //    [self.user.skills addObject:skill];
       // } else if (skill.isOtherSkill){
       //     [self.user.otherSkills addObject:skill];
       // }
    }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

   
     
 }

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    _skillString = textField.text;
    textField.text = @"";
}



- (IBAction)addNewSkillAction:(id)sender {
    
    [self.view endEditing:YES];
    
    Skill *newSkill = [[Skill alloc] init];
    NSNumber *skillId = [[NSNumber alloc] init];
    
    skillId = @(arc4random_uniform(51) + 400);
    
    if ([_randomNumbers containsObject:skillId]) {
        skillId = @(arc4random_uniform(51) + 400);
    }
    else {
        
        if (_skillString.length > 0) {
            
            [_randomNumbers addObject:skillId];
            
            newSkill.skillId = skillId;
            newSkill.name = _skillString;
            newSkill.isOtherSkill = YES;
            
            [_skilsArray addObject:newSkill];
            [self buildInterface];
            [self scrollToBottom];
            
        } else {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You must enter a skill" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }
}

- (void)scrollToBottom {
    
    CGPoint scrollPoint = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
    [self.tableView setContentOffset:scrollPoint animated:YES];
}


@end
