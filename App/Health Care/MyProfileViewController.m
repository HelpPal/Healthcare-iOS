//
//  MyProfileViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "MyProfileViewController.h"
#import "SpaceCell.h"
#import "MyProfileCredentialsCell.h"

#import "MultiLineStringCell.h"
#import "ProfileExperienceAndPriceRangeCell.h"
#import "TaggedStringCell.h"
#import "RegistrationStep3ViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"My profile";
    
    [DataLoader individualUserProfile:self.user.userId  myuserid:self.user.userId success:^(User *user) {
        self.user = user;
        [self buildInterface];
    } fail:^(NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, 75, 38);
    editButton.backgroundColor = [AppUtils buttonBlueColor];
    editButton.titleLabel.font = [UIFont fontWithName:_lato_font_regular size:14];
    editButton.layer.cornerRadius = 12.0f;
    [editButton addTarget:self action:@selector(editProfile:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    
    self.navigationItem.rightBarButtonItem = rightButton;

   
     
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)buildInterface
{
    
    NSMutableArray *section = [NSMutableArray new];
    
    
    {
        MyProfileCredentialsCellSource *cellSource = [MyProfileCredentialsCellSource new];
        cellSource.user = self.user;
        cellSource.myUserID = self.user.userId;
        [section addObject:cellSource];
    }
    
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        ProfileExperienceAndPriceRangeCellSource *cellSource = [ProfileExperienceAndPriceRangeCellSource new];
        cellSource.user = self.user;
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = self.user.userDescriptionDetails;
        cellSource.fontSize = 15;
        cellSource.textColor = [UIColor darkTextColor];
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 18;
        [section addObject:cellSource];
    }
    
    {
        TaggedStringCellSource *cellSource = [TaggedStringCellSource new];
        cellSource.user = self.user;
        cellSource.showAllTags = YES;
        [section addObject:cellSource];
    }
    
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}

-(IBAction)editProfile:(id)sender
{
   
 [self performSegueWithIdentifier:segue_showEditMyProfileProfesional sender:nil];

}

-(IBAction)applyButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    [super keyboardWillShow:notification];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height + self.keyboardHeight) animated:YES];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [super keyboardWillHide:notification];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height ) animated:YES];
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     [super prepareForSegue: segue sender:sender];
     
     RegistrationStep3ViewController * editProfile = segue.destinationViewController;
     editProfile.isEditing = YES;
    
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
