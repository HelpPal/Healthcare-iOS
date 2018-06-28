//
//  AddNewJobViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "AddNewJobViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "BlueButtonRoundedCell.h"
#import "InputFieldCell.h"
#import "MultiLineStringCell.h"
#import "DataSelectorCell.h"
#import "DoubleRadioButtonCell.h"
#import "PriceRangeCell.h"
#import "JobDescribtionInputViewCell.h"
#import "WeekDaysCell.h"
#import "HoursPerDayCell.h"
#import "LocationMapViewController.h"


@interface AddNewJobViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceTableView;
@property (nonatomic,assign)  BOOL didAgreeTermsAndConditions;
@property (retain, nonatomic)  Job *editedJob;
@property (nonatomic,strong)  NSMutableIndexSet* daysSet;
@end

@implementation AddNewJobViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = [_isEditing ? @"Edit" : @"Add"  stringByAppendingString:@" job"];
    if (_isEditing )
    {
        _daysSet = [NSMutableIndexSet new];
        _editedJob = _jobToEdit;
        for (Day * day in _jobToEdit.days)
        {
            [_daysSet addIndex:[day.day integerValue]];
        }
    }
    
    else
    {
        if ([AppUtils isValidObject:_editedJob] == NO) {
            _editedJob = [Job new];
            _editedJob.min_price = @"15";
            _editedJob.max_price = @"120";
            _daysSet = [NSMutableIndexSet new];
            [_daysSet addIndexesInRange:NSMakeRange(1, 5)];
        }
    }
    
    
    
    [self buildInterface];
}


- (void)viewDidLoad {
    [super viewDidLoad];
       self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
   
    
    
    
    // Do any additional setup after loading the view.
}



-(void)buildInterface
{
    [_editedJob.days removeAllObjects];
    [_daysSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        Day * day = [Day new];
        day.day = @(idx);
        [_editedJob.days addObject:day];
    }];
    
    NSMutableArray *section = [NSMutableArray new];
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 13;
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
        cellSource.inputText = _editedJob.title;
        cellSource.textFieldTag = 1;
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
        cellSource.buttonTitle = _editedJob.location.country.length ? [_editedJob.location.city stringByAppendingFormat:@", %@",_editedJob.location.country] :   @"Location...";
        cellSource.enabled = _editedJob.location.country.length;
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
        cellSource.minPriceString = _editedJob.min_price;
        cellSource.maxPriceString = _editedJob.max_price;
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
        cellSource.job = _editedJob;
        [section addObject:cellSource];
    }

    {
        DoubleRadioButtonCellSource *cellSource = [DoubleRadioButtonCellSource new];
        cellSource.selectedItem = _editedJob.repate;
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
        cellSource.selectedItem = _editedJob.avalable;
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
    
    
    if (_editedJob.avalable == _partTime) {
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
            cellSource.job = _editedJob;
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
        JobDescribtionInputViewCellSource *cellSource = [JobDescribtionInputViewCellSource new];
        cellSource.job = _editedJob;
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
        cellSource.selector = @selector(saveData:);
        cellSource.buttonTitle = _isEditing ? @"Save" : @"Add job";
        cellSource.padding = _isEditing ? 20 : 105;
        [section addObject:cellSource];
    }
    
   
    
    if (_isEditing) {
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 10;
            [section addObject:cellSource];
        }
        
        
        // next button
        {
            BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
            cellSource.selector = @selector(deleteThisJob:);
            cellSource.buttonBackColor = [AppUtils separatorsColor];
            cellSource.buttonTitle =  @"Delete this job";
            cellSource.buttonTitleColor = [AppUtils buttonRedTextColor];
            cellSource.padding = 20;
            [section addObject:cellSource];
        }
        
        
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




-(IBAction)deleteThisJob:(UIButton*)sender
{
    
    [DataLoader deleteUserJob:self.user.userId withJobId:_editedJob.jobId success:^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {

    }];
    
}







- (void)textViewDidChange:(UITextView *)textView
{
    _editedJob.information = textView.text;
}


- (void)textFieldDidChange:(UITextField *)textField
{
    NSInteger tag = textField.tag;
    
    switch (tag) {
            
        case 1:
            _editedJob.title = textField.text;
            break;
            
        case 100:
      
            _editedJob.min_price = textField.text;
            break;
            
        case 101:
           
            _editedJob.max_price = textField.text;
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





-(IBAction)selectRepeatDays:(UIButton*)sender
{
    _editedJob.repate = !_editedJob.repate;
    [self buildInterface];
    
}

-(IBAction)addHourForDay:(UIButton*)sender
{
    _editedJob.hours = @([_editedJob.hours intValue] + 1);
    if ([_editedJob.hours intValue] >24) {
        _editedJob.hours = @(24);
        
    }
    
    [self buildInterface];
    
}

-(IBAction)removeHourForDay:(UIButton*)sender
{
    
    _editedJob.hours = @([_editedJob.hours intValue] - 1);
    if ([_editedJob.hours intValue] < 1) {
        _editedJob.hours = @(1);
    }
    [self buildInterface];
    
}






-(IBAction)selectAvailability:(UIButton*)sender
{
    
    _editedJob.avalable = (AvailableTime)sender.tag;
    [self buildInterface];
    
}



-(IBAction)selectLocation:(id)sender
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self performSegueWithIdentifier:segue_showLocationMap sender:nil];
}



-(NSString*)atemptedError
{
    NSString *errorString = @"";
    
        
        if (_editedJob.title.length == 0) {
            errorString = @"Please fill title field";
        }
    
    
        
        else if (_editedJob.location.city.length + _editedJob.location.country.length == 0 ) {
            errorString = @"Please select your location";
        }
    
    
        else if ([_editedJob.min_price integerValue] < 15 ||
                 [_editedJob.max_price integerValue] < 15 ||
                 [_editedJob.min_price integerValue] > 120 ||
                 [_editedJob.max_price integerValue] > 120)
        {
            errorString = @"Price range should be between 15 and 120";
        }
        
    
    
        else if (_editedJob.information.length == 0) {
            errorString = @"Add small description info in description field";
        }
        
    
    if (errorString.length) {
        NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
        [DataLoader alertUserForError:error];
    }
    
    return errorString;
}



-(IBAction)saveData:(id)sender
{
    
    
    NSString *errorString = [self atemptedError];
    if (errorString.length == 0) {
        [DataLoader addJobEdit:_editedJob withMyUserId:self.user.userId isEditing:_isEditing isPrivate:NO success:^(Job * job) {
            _jobToEdit = job;
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(NSError *error) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segue_showLocationMap])
    {
        LocationMapViewController * mapVC = segue.destinationViewController;
        mapVC.job = _editedJob;
    }
}


@end
