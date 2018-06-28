//
//  CreateOfferViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "CreateOfferViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "BlueButtonRoundedCell.h"
#import "InputFieldCell.h"
#import "MultiLineStringCell.h"
#import "DataSelectorCell.h"
#import "DoubleRadioButtonCell.h"
#import "PriceRangeCell.h"
#import "UserDescribtionInputViewCell.h"
#import "WeekDaysCell.h"
#import "HoursPerDayCell.h"
#import "LocationMapViewController.h"
#import "JobSummaryViewController.h"

@interface CreateOfferViewController ()

@property (nonatomic,strong)  Job* job;
@property (nonatomic,strong)  NSMutableIndexSet* daysSet;
@end

@implementation CreateOfferViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _job = [Job new];
        _daysSet = [NSMutableIndexSet new];
        [_daysSet addIndexesInRange:NSMakeRange(1, 5)];
    
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _job = [Job new];
        _daysSet = [NSMutableIndexSet new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Create offer";
    [self buildInterface];
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

}




-(void)buildInterface
{
    [_job.days removeAllObjects];
    [_daysSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        Day * day = [Day new];
        day.day = @(idx);
        [_job.days addObject:day];
    }];
    
    
    NSMutableArray *section = [NSMutableArray new];
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 15;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Creating an offer for";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 5;
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = _forUser.fullName;
        cellSource.fontSize = 24;
        cellSource.staticHeightForCell = 62;
        cellSource.textColor = [AppUtils inputFieldTextColor];
        cellSource.textAlignment = NSTextAlignmentLeft;
        cellSource.backgroundColor = [AppUtils lightBlueColor];
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 15;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"This is a private offer that will only be seen by the person you send it to. It will not be displayed in your jobs list.";
        cellSource.fontSize = 16;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Title";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 5;
        [section addObject:cellSource];
    }
    {
        InputFieldCellSource *cellSource = [InputFieldCellSource new];
        cellSource.textFieldTag = 1;
        cellSource.inputText = _job.title;
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 9;
        [section addObject:cellSource];
    }
    
    
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Location";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    
    
    {
        DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
        cellSource.buttonTitle = _job.location.country.length ? [_job.location.city stringByAppendingFormat:@", %@",_job.location.country] :   @"Location...";
        cellSource.enabled = _job.location.country.length;
        cellSource.selector = @selector(selectLocation:);
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Price range";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 4;
        [section addObject:cellSource];
    }
    
    {
        PriceRangeCellSource *cellSource = [PriceRangeCellSource new];
        cellSource.minPriceTag = 100;
        cellSource.maxPriceTag = 101;
        cellSource.minPriceString = _job.min_price;
        cellSource.maxPriceString = _job.max_price;
        cellSource.target = self;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Days of the week";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 10;
        [section addObject:cellSource];
    }
    {
        SeparatorCellSource *cellSource = [SeparatorCellSource new];
        [section addObject:cellSource];
    }
    {
        WeekDaysCellSource *cellSource = [WeekDaysCellSource new];
        cellSource.target = self;
        cellSource.job = _job;
        [section addObject:cellSource];
    }
    {
        DoubleRadioButtonCellSource *cellSource = [DoubleRadioButtonCellSource new];
        cellSource.selectedItem = _job.repate;
        cellSource.selector = @selector(selectRepeatDays:);
        cellSource.leftItemName = @"Repeatedly";
        cellSource.rightItemName = @"One time";
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 20;
        [section addObject:cellSource];
    }
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Availability";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 7;
        [section addObject:cellSource];
    }
    
    {
        DoubleRadioButtonCellSource *cellSource = [DoubleRadioButtonCellSource new];
        cellSource.selectedItem = _job.avalable;
        cellSource.selector = @selector(selectAvailability:);
        cellSource.leftItemName = @"Full time";
        cellSource.rightItemName = @"Part time";
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 20;
        [section addObject:cellSource];
    }
    
    
    if (_job.avalable == _partTime) {
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"Hours per day";
            cellSource.fontSize = 18;
            cellSource.textAlignment = NSTextAlignmentLeft;
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 15;
            [section addObject:cellSource];
        }

        {
            HoursPerDayCellSource *cellSource = [HoursPerDayCellSource new];
            cellSource.plusSelector = @selector(addHourForDay:);
            cellSource.minusSelector = @selector(removeHourForDay:);
            cellSource.job = _job;
            [section addObject:cellSource];
        }
    }
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 10;
        [section addObject:cellSource];
    }
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Description";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 5;
        [section addObject:cellSource];
    }
    
    {
        
        UserDescribtionInputViewCellSource *cellSource = [UserDescribtionInputViewCellSource new];
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    
    
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }
    
    
    // next button
    {
        BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
        cellSource.selector =  @selector(sendOffer:);
        cellSource.buttonTitle = @"Send offer";
        cellSource.padding = 105;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 25;
        [section addObject:cellSource];
    }

    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    _job.information = textView.text;
}


- (void)textFieldDidChange:(UITextField *)textField
{
    NSInteger tag = textField.tag;
    
    switch (tag) {
       
        case 1:
            _job.title = textField.text;
            break;
            
        case 100:
            
            _job.min_price = textField.text;
            break;
            
        case 101:
           
            _job.max_price = textField.text;
            break;
            
        default:
            break;
    }
    
}

-(void)multiSelect:(MultiSelectSegmentedControl*) multiSelecSegmendedControl didChangeValue:(BOOL) value atIndex: (NSUInteger) index
{
    if (value == NO) {
        [_daysSet addIndex:index];
    }
    else
    {
        [_daysSet removeIndex:index];
    }

    
    [self buildInterface];
    
}

-(IBAction)sendOffer:(UIButton*)sender
{
 
    NSString *errorString = @"";
     if (_job.min_price.length == 0 || _job.max_price.length == 0) {
        errorString = @"Please add price range";
    }
    
    else if ([_job.min_price integerValue] < 15 ||
             [_job.max_price integerValue] < 15 ||
             [_job.min_price integerValue] > 120 ||
             [_job.max_price integerValue] > 120)
    {
        errorString = @"Price range should be between 15 and 120";
    }
    if (errorString.length == 0) {
        [self performSegueWithIdentifier:segue_showJobSummary sender:nil];
    }
    
    else
    {
        if (errorString.length) {
            NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
            [DataLoader alertUserForError:error];
        }
    }
    
  
    
}




-(IBAction)selectRepeatDays:(UIButton*)sender
{
    _job.repate = !_job.repate;
    [self buildInterface];
    
}

-(IBAction)addHourForDay:(UIButton*)sender
{
    _job.hours = @([_job.hours intValue] + 1);
    if ([_job.hours intValue] >24) {
        _job.hours = @(24);
        
    }

    [self buildInterface];
    
}

-(IBAction)removeHourForDay:(UIButton*)sender
{
    
    _job.hours = @([_job.hours intValue] - 1);
    if ([_job.hours intValue] < 1) {
        _job.hours = @(1);
    }
    [self buildInterface];
    
}






-(IBAction)selectAvailability:(UIButton*)sender
{
    
    _job.avalable = (AvailableTime)sender.tag;
    [self buildInterface];
    
}



-(IBAction)selectLocation:(id)sender
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self performSegueWithIdentifier:segue_showLocationMap sender:nil];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     [super prepareForSegue:segue sender:sender];
     
     if ([segue.identifier isEqualToString:segue_showLocationMap]) {
         LocationMapViewController * map = segue.destinationViewController;
         map.job = _job;

     }
     
     if ([segue.identifier isEqualToString:segue_showJobSummary]) {
         JobSummaryViewController * summary = segue.destinationViewController;
         summary.offerJob = _job;
         summary.assistantUser = _forUser;

     }
    
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
