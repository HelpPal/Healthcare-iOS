//
//  CertifiedNursingAssistantProfileViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "CertifiedNursingAssistantProfileViewController.h"
#import "SpaceCell.h"
#import "MyProfileCredentialsCell.h"
#import "MultiLineStringCell.h"
#import "ProfileExperienceAndPriceRangeCell.h"
#import "TaggedStringCell.h"
#import "RegistrationStep3ViewController.h"
#import "BlueButtonRoundedCell.h"
#import "JobDetailsSendMessageCell.h"
#import "ReportButtonCell.h"
#import "HireAssistantViewController.h"
#import "UIButton+InfoObject.h"



@interface CertifiedNursingAssistantProfileViewController ()

@end

@implementation CertifiedNursingAssistantProfileViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = [_nurseProfileUser.fullName stringByAppendingString: @"'s profile"];
    [DataLoader individualUserProfile:_nurseProfileUser.userId  myuserid:self.user.userId success:^(User *user) {
        
        _nurseProfileUser = user;
        [self buildInterface];
    } fail:^(NSError *error) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
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
        cellSource.user = _nurseProfileUser;
            cellSource.myUserID = self.user.userId;
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        ProfileExperienceAndPriceRangeCellSource *cellSource = [ProfileExperienceAndPriceRangeCellSource new];
        cellSource.user = _nurseProfileUser;
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
        cellSource.infoText = _nurseProfileUser.userDescriptionDetails;
        cellSource.fontSize = 15;
        cellSource.textColor = [UIColor darkTextColor];
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 40;
        [section addObject:cellSource];
    }
    {
        BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
        cellSource.buttonTitle = @"Hire";
        cellSource.object = _nurseProfileUser;
        cellSource.selector = @selector(hireButtonPressed:);
        cellSource.padding = 85;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 30;
        [section addObject:cellSource];
    }
    {
        TaggedStringCellSource *cellSource = [TaggedStringCellSource new];
        cellSource.user = _nurseProfileUser;
        cellSource.showAllTags = YES;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Send a message";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    
    {
        JobDetailsSendMessageCellSource *cellSource = [JobDetailsSendMessageCellSource new];
        cellSource.placeholderString = [NSString stringWithFormat:@"Tap here to ask %@ a question or leave %@ a feedback...", _nurseProfileUser.fullName, _nurseProfileUser.gender == _female ? @"her" : @"him"];
        cellSource.selector = @selector(sendMessage:);
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    
    {
        ReportButtonCellSource *cellSource = [ReportButtonCellSource new];
        
        cellSource.buttonTitle = [@"Report " stringByAppendingFormat: @"%@’s profile",_nurseProfileUser.fullName];
        cellSource.buttonSelector = @selector(reportThisAssistant:);
        [section addObject:cellSource];
    }
    
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}


-(IBAction)reportThisAssistant:(UIButton*)sender
{
    sender.userInteractionEnabled = NO;
    [DataLoader reportUserFromUser:self.user.userId reportedUserId:_nurseProfileUser.userId success:^(id responseObject) {
    sender.alpha = 0.3;
    } fail:^(NSError *error) {
    sender.userInteractionEnabled = YES;
    }];
}



-(IBAction)hireButtonPressed:(UIButton*)sender
{
    [self performSegueWithIdentifier:segue_showHireAssistant sender:_nurseProfileUser];
}



- (IBAction)sendMessage:(UIButton *)sender {
    
    UITextView * textView = sender.infoObject;
    if (textView.text.length) {
        
        textView.text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [DataLoader sendMessageFromUser:self.user.userId toPartner:_nurseProfileUser.userId text:textView.text success:^(id responseObject) {
            textView.text = @"";
        } fail:^(NSError *error) {
            
        }];
    }
    
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

// // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:segue_showHireAssistant]) {
        
        HireAssistantViewController * hire = segue.destinationViewController;
        hire.profiledUser = sender;
    }
    
    //Get the new view controller using [segue destinationViewController].
    // // Pass the selected object to the new view controller.
}


@end
