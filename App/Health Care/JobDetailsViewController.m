//
//  JobDetailsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "JobDetailsViewController.h"
#import "SpaceCell.h"
#import "BlueButtonRoundedCell.h"
#import "JobDetailsTitleCell.h"

#import "JobDetailsDaysAndPriceCell.h"
#import "MultiLineStringCell.h"
#import "JobDetailsSendMessageCell.h"
#import "ReportButtonCell.h"
#import "AddNewJobViewController.h"

@interface JobDetailsViewController ()
@property (nonatomic,assign) BOOL apliedToJob;
@end

@implementation JobDetailsViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Job Details";
    
    [DataLoader userCanApplyToJob:self.user.userId jobId:_job.jobId success:^(NSNumber* responseObject) {
        [self buildInterface];
        [self.view layoutIfNeeded];
    } fail:^(NSError *error) {
        _apliedToJob = YES;
        [self buildInterface];
        [self.view layoutIfNeeded];
    }];
 
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (self.user.type == _individual && _hideEditButton == NO)
    {
        UIImage *rightButtonImage = [UIImage imageNamed:@"editJobIcon"];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStyleDone target:self action:@selector(editThisJob:)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    
   
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
        JobDetailsTitleCellSource *cellSource = [JobDetailsTitleCellSource new];
        cellSource.job = _job;
        cellSource.userID = self.user.userId;
        [section addObject:cellSource];
    }
    
    {
        JobDetailsDaysAndPriceCellSource *cellSource = [JobDetailsDaysAndPriceCellSource new];
        cellSource.job = _job;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = _job.information;
        cellSource.fontSize = 14;
        cellSource.textColor = [UIColor darkTextColor];
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    
    if (self.user.type == _profesional)
    {
        
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 40;
            [section addObject:cellSource];
        }
        {
            BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
            cellSource.buttonTitle = @"Apply";
            cellSource.padding = 85;
            cellSource.selector = @selector(applyButtonPressed:);
            cellSource.blockButton = _apliedToJob;
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
            cellSource.placeholderString = @"Tap here to ask a question about this job…";
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
            cellSource.buttonTitle = @"Report this job";
            cellSource.buttonSelector = @selector(reportThisJob:);
            [section addObject:cellSource];
        }
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}


-(IBAction)sendMessage:(UIButton*)sender
{
    UITextView * textView = sender.infoObject;
    if (textView.text.length) {
        textView.text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [DataLoader sendMessageFromUser:self.user.userId toPartner:_job.byUser text:textView.text success:^(id responseObject) {
            [self buildInterface];
            textView.text = @"";
        } fail:^(NSError *error) {
            
        }];
    }
}


-(IBAction)editThisJob:(id)sender
{
    [self performSegueWithIdentifier:segue_showEditJob sender:nil];
    
}

-(IBAction)reportThisJob:(UIButton*)sender
{
    
    sender.userInteractionEnabled = NO;
    
    
    [DataLoader reportJobFromUser:self.user.userId jobId:_job.jobId success:^(id responseObject) {
    sender.alpha = 0.3;
    } fail:^(NSError *error) {
    sender.userInteractionEnabled = YES;
    }];
    
}

-(IBAction)applyButtonPressed:(id)sender
{
    
    [DataLoader userCanApplyToJob:self.user.userId jobId:_job.jobId success:^(NSNumber* responseObject) {
        
        [DataLoader sendJobTouser:self.user.userId byUser:_job.byUser jobId:_job.jobId invite:NO success:^(id responseObject) {
            
            [self performSegueWithIdentifier:segue_showApplications sender:nil];
            
        } fail:^(NSError *error) {
            
        }];
        
    } fail:^(NSError *error) {
        _apliedToJob = YES;
        [self buildInterface];
    }];
    
    
    
   
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    [super keyboardWillShow:notification];
    
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [super keyboardWillHide:notification];
    
}



 #pragma mark - Navigation
 
//  In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     [super prepareForSegue:segue sender:sender];
     
     
     if ([segue.identifier isEqualToString: segue_showEditJob]) {
         AddNewJobViewController * editJob = (AddNewJobViewController*)segue.destinationViewController;
         editJob.isEditing = YES;
         editJob.jobToEdit = _job;
     }
     
 }
 

@end
