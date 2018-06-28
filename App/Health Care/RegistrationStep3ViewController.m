//
//  RegistrationStep3ViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "RegistrationStep3ViewController.h"
#import "BlueTitleAndSubtitleCell.h"
#import "SpaceCell.h"
#import "BlueButtonRoundedCell.h"
#import "InputFieldCell.h"
#import "MultiLineStringCell.h"
#import "TermsAndConditionsCell.h"
#import "TermsAndConditionsViewController.h"
#import "DataSelectorCell.h"
#import "DoubleRadioButtonCell.h"
#import "PriceRangeCell.h"
#import "UserDescribtionInputViewCell.h"
#import "AddUserPhotoCell.h"
#import "RegistrationStep4ViewController.h"

//update
#import <CoreLocation/CoreLocation.h>

//


@interface RegistrationStep3ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceTableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerHeight;
@property (weak, nonatomic) IBOutlet UIButton *hidePickerButton;
@property (retain, nonatomic)  UIImage *userImage;
@property (nonatomic,assign)  BOOL didAgreeTermsAndConditions;
@property (nonatomic, assign) NSString *tempBirthday;

//update
@property (strong, nonatomic) Job *job;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;
@property (assign, nonatomic) BOOL existsCoordinates;
//

@property BOOL newImage;
@end

@implementation RegistrationStep3ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self buildInterface];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _userImage = [UIImage imageNamed:@"userProfilePhoto"];
    _datePicker.maximumDate = [NSDate date];
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    _newImage = false;
 
    _tempBirthday = @"Birthday";
        
    
    [_datePicker addTarget:self action:@selector(date)   forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view.
}

-(void)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    _tempBirthday = [dateFormatter stringFromDate:[self.datePicker date]];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd 15:40:03"];
    
    self.user.birthday = [dateFormatter stringFromDate:[self.datePicker date]];
    [self buildInterface];
    
}


-(void)buildInterface
{
    
    NSMutableArray *section = [NSMutableArray new];
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 10;
        [section addObject:cellSource];
    }
    //Title and subtitle Cell
    
    if (_isEditing == NO) {
        {
            BlueTitleAndSubtitleCellSource *cellSource = [BlueTitleAndSubtitleCellSource new];
            cellSource.title = @"Registration: Step 3";
            cellSource.subtitle = @"Profile information";
            [section addObject:cellSource];
        }
        
        // Input fields
        
        
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 35;
            [section addObject:cellSource];
        }
    }
    
    
   
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"First name";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 3;
        [section addObject:cellSource];
    }
    
    {
        InputFieldCellSource *cellSource = [InputFieldCellSource new];
        
        // update
        cellSource.enableUpperCase = YES;
        //
        
        cellSource.textFieldTag = 0;
        cellSource.inputText = self.user.first_name;
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 7;
        [section addObject:cellSource];
    }
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Last name";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 3;
        [section addObject:cellSource];
    }
    
    {
        InputFieldCellSource *cellSource = [InputFieldCellSource new];
        
        // update
        cellSource.enableUpperCase = YES;
        //
        
        cellSource.textFieldTag = 1;
        cellSource.inputText = self.user.last_name;
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 7;
        [section addObject:cellSource];
    }
    
    
    /* default
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"City, state";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 3;
        [section addObject:cellSource];
    }
    
    {
//        DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
//        cellSource.selector = @selector(selectUserLocationCoordinates);
//        cellSource.buttonTitle = self.user.location.country.length ? [self.user.location.city stringByAppendingFormat:@", %@",self.user.location.country] :   @"Location...";
//        cellSource.target = self;
//        cellSource.enabled = self.user.location.country.length;
//        [section addObject:cellSource];
        
        DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
        cellSource.selector = @selector(selectUserLocationCoordinates);
        
        cellSource.textFieldTag = 991;
        cellSource.inputText = self.user.location.country.length ? [self.user.location.city stringByAppendingFormat:@", %@",self.user.location.country] :   @"";
        cellSource.target = self;
        
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 7;
        [section addObject:cellSource];
    }
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Address";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 3;
        [section addObject:cellSource];
    }
    
    {
        InputFieldCellSource *cellSource = [InputFieldCellSource new];
        cellSource.textFieldTag = 2;
        cellSource.inputText = self.user.location.address;
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 7;
        [section addObject:cellSource];
    }
    */
    
    
    
    
    
    // update

    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Address";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 3;
        [section addObject:cellSource];
    }
    
    {
        DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
        cellSource.selector = @selector(selectUserLocationCoordinates);
        
        cellSource.isMapType = YES;
        cellSource.textFieldTag = 991;
        cellSource.inputText = self.user.location.address;
        //self.user.location.country.length ? [self.user.location.city stringByAppendingFormat:@", %@",self.user.location.country] :   @"";
        cellSource.target = self;
        
        [section addObject:cellSource];
    }
    
    
    
    
    
    
    
    
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"City";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 3;
        [section addObject:cellSource];
    }
    
    {
        InputFieldCellSource *cellSource = [InputFieldCellSource new];
        // update
        cellSource.enableUpperCase = YES;
        //
        cellSource.textFieldTag = 992;
        cellSource.inputText = self.user.location.city;
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 7;
        [section addObject:cellSource];
    }
    
    
    
    

    
   
    
    
    
    
    
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"State";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 3;
        [section addObject:cellSource];
    }
    
    {
        InputFieldCellSource *cellSource = [InputFieldCellSource new];
        // update
        cellSource.enableUpperCase = YES;
        //
        cellSource.textFieldTag = 993;
        cellSource.inputText = self.user.location.state;
        if(cellSource.inputText.length == 0)
        {
            cellSource.inputText  =  self.user.location.country;
        }
        
        cellSource.target = self;
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 7;
        [section addObject:cellSource];
    }
    
    
    
    
    
    
 

    
    
    
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Zip Code";
        cellSource.fontSize = 18;
        cellSource.textAlignment = NSTextAlignmentLeft;
        [section addObject:cellSource];
    }
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 3;
        [section addObject:cellSource];
    }
    
    {
        InputFieldCellSource *cellSource = [InputFieldCellSource new];
        
        // update
        cellSource.enableUpperCase = YES;
        //
        
        cellSource.textFieldTag = 994;
        cellSource.inputText = self.user.zipCode;
        cellSource.target = self;
        [section addObject:cellSource];
    }
    //
    
    
    if (self.user.type == _individual)
    {
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Phone number";
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
        cellSource.textFieldTag = 3;
        cellSource.keyboardType = UIKeyboardTypePhonePad;
        cellSource.inputText = [self.user.phone isEqualToString:@""] ? @"+1" : self.user.phone;
        cellSource.target = self;
        [section addObject:cellSource];
    }
}
    
    if (self.user.type == _profesional)
    {
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"Your skills";
            cellSource.fontSize = 18;
            cellSource.textAlignment = NSTextAlignmentLeft;
            [section addObject:cellSource];
        }
        
        
        {
            NSMutableArray * namesArray = [NSMutableArray new];
            
            [self.user.skills enumerateObjectsUsingBlock:^(Skill *skill, NSUInteger idx, BOOL * _Nonnull stop) {
                [namesArray addObject:skill.name];
            }];
            
            
            DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
            cellSource.buttonTitle = namesArray.count ? [namesArray componentsJoinedByString:@", "] : @"None...";
            cellSource.selector = @selector(selectUserSkill:);
            cellSource.target = self;
            cellSource.enabled = self.user.skills.count;
            [section addObject:cellSource];
        }
        
        
        
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"Experience";
            cellSource.fontSize = 18;
            cellSource.textAlignment = NSTextAlignmentLeft;
            [section addObject:cellSource];
        }
        
        
        {
            DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
            cellSource.buttonTitle = [AppUtils experienceArray][[self.user.experience integerValue]];
            cellSource.selector = @selector(selectUserExperienceTime:);
            cellSource.target = self;
            cellSource.enabled = YES;
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
            cellSource.staticHeightForCell = 5;
            [section addObject:cellSource];
        }
        
        
        {
            DoubleRadioButtonCellSource *cellSource = [DoubleRadioButtonCellSource new];
            cellSource.selectedItem = self.user.available_time;
            cellSource.selector = @selector(selectAvailability:);
            cellSource.leftItemName = @"Full time";
            cellSource.rightItemName = @"Part time";
            cellSource.target = self;
            [section addObject:cellSource];
        }
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 10;
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
            cellSource.maxPriceTag= 101;
            cellSource.minPriceString = self.user.price_min;
            cellSource.maxPriceString = self.user.price_max;
            cellSource.target = self;
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 10;
            [section addObject:cellSource];
        }
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"Phone number";
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
            cellSource.textFieldTag = 3;
            cellSource.keyboardType = UIKeyboardTypePhonePad;
            cellSource.inputText = [self.user.phone isEqualToString:@""] ? @"+1" : self.user.phone;
            cellSource.target = self;
            [section addObject:cellSource];
        }
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 10;
            [section addObject:cellSource];
        }
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"Birthday";
            cellSource.fontSize = 18;
            cellSource.textAlignment = NSTextAlignmentLeft;
            [section addObject:cellSource];
        }
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 2;
            [section addObject:cellSource];
        }
        {
            DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
            cellSource.buttonTitle = _tempBirthday;
            cellSource.enabled = self.user.birthday.length;
            cellSource.selector = @selector(setUserBirthDay:);
            cellSource.target = self;
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
            cellSource.user = self.user;
            [section addObject:cellSource];
        }
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 15;
            [section addObject:cellSource];
        }
        
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"Profile picture";
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
            
          
            
            AddUserPhotoCellSource *cellSource = [AddUserPhotoCellSource new];
            cellSource.userImage = _userImage;
            if (_isEditing == true && !_newImage) {
                
                cellSource.userURL = self.user.profile_img;
                
           
            }
            cellSource.takePhotoSelector = @selector(takePhoto:);
            cellSource.uploadSelector = @selector(uploadFoto:);
            [section addObject:cellSource];
        }
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 45;
            [section addObject:cellSource];
        }
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = @"Gender";
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
            DoubleRadioButtonCellSource *cellSource = [DoubleRadioButtonCellSource new];
            cellSource.selectedItem = self.user.gender;
            cellSource.selector = @selector(setUserGender:);
            cellSource.leftItemName = @"Female";
            cellSource.rightItemName = @"Male";
            cellSource.target = self;
            [section addObject:cellSource];
        }
        
        
        
    }
    
    if(_isEditing == NO)
    {
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 15;
            [section addObject:cellSource];
        }
        
        
        {
            TermsAndConditionsCellSource *cellSource = [TermsAndConditionsCellSource new];
            cellSource.selector = @selector(acceptOrNotTerms:);
            cellSource.readTermsAndConditionsSelector = @selector(readTermsAndConditions:);
            cellSource.didAgreeTermsAndConditions = _didAgreeTermsAndConditions;
            [section addObject:cellSource];
        }
        
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 35;
        [section addObject:cellSource];
    }
    
    
    // next button
    {
        BlueButtonRoundedCellSource *cellSource = [BlueButtonRoundedCellSource new];
        cellSource.selector = _isEditing ? @selector(saveData:) : @selector(nextStep:);
        cellSource.padding = 105;
        cellSource.buttonTitle = _isEditing ? @"Save" : @"Next step";
        [section addObject:cellSource];
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 35;
        [section addObject:cellSource];
    }
    
    [self.tableView.source removeAllObjects];
    [self.tableView.source addObject:section];
    [self.tableView reloadData];
    
    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UITableViewCell * cell = (UITableViewCell*)textView.superview.superview.superview;
    NSIndexPath * indexpath = [self.tableView indexPathForCell:cell];
    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.user.userDescriptionDetails = textView.text;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType = UIReturnKeyDone;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger tag = textField.tag;
    if (tag == 3) {
        if (NSLocationInRange(range.location, NSMakeRange(0, 2)) ) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_isEditing)
    {
        [self saveData:nil];
    }
    else
    {
        [self nextStep:nil];
    }
    
    return NO;
}



//update
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//
//    NSInteger tag = textField.tag;
//
//    switch (tag) {
//        case 991:
//            [self coordinatesForAddress:self.user.location.address];
//
//            NSLog(@"Coordinates lat = %@, long = %@", self.user.address_lat, self.user.address_long);
//
//            break;
//
//        case 992:
//
//            break;
//
//        case 993:
//
//            break;
//
//        case 994:
//
//            break;
//    }
//}
//



-(void)textFieldDidEndEditing:(UITextField *)textField
{
        NSInteger tag = textField.tag;
    switch (tag) {
        case 0:
            self.user.first_name = textField.text;
            break;
        case 1:
            self.user.last_name = textField.text;
            
            break;
        case 2:
            //            self.user.location.address = textField.text;
            break;
            
        case 3:
            self.user.phone = textField.text;
            break;
            
        case 100:
            
            self.user.price_min = textField.text;
            break;
            
        case 101:
            
            self.user.price_max = textField.text;
            break;
            
            
            
            // update
        case 991:
        {
            self.user.location.address = textField.text;
            [self coordinatesForAddress];
        }
            break;
            
        case 992:
        {
            self.user.location.city = textField.text;
            
            [self coordinatesForAddress];
        }
            break;
            
        case 993:
            self.user.location.state = textField.text;
            [self coordinatesForAddress];
            break;
            
        case 994:
            self.user.zipCode = textField.text;
            break;
            //
            
            
        default:
            break;
    }
}
- (void)textFieldDidChange:(UITextField *)textField
{
    NSInteger tag = textField.tag;
    
    switch (tag) {
        case 0:
            self.user.first_name = textField.text;
            break;
        case 1:
            self.user.last_name = textField.text;
            
            break;
        case 2:
//            self.user.location.address = textField.text;
            break;
        
        case 3:
            self.user.phone = textField.text;
            break;
            
        case 100:
            
            self.user.price_min = textField.text;
            break;
            
        case 101:
            
            self.user.price_max = textField.text;
            break;
            
            
           
     // update
        case 991:
        {
            self.user.location.address = textField.text;
     
        }
            break;
            
        case 992:
        {
            self.user.location.city = textField.text;
          
      
        }
            break;
            
        case 993:
            self.user.location.state = textField.text;
            
            break;
            
        case 994:
            self.user.zipCode = textField.text;
            break;
    //
            
            
        default:
            break;
    }

}




-(IBAction)setUserGender:(UIButton*)sender
{
    self.user.gender = (Gender)sender.tag;
    [self buildInterface];
    
}



-(void)selectUserLocationCoordinates
{
    [self.navigationController setNavigationBarHidden:YES];
    [self performSegueWithIdentifier:segue_showLocationMap sender:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _userImage = chosenImage;
    _newImage = true;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self buildInterface];
    }];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(IBAction)takePhoto:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}

-(IBAction)uploadFoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


- (IBAction)hidePickerView:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        _bottomSpaceTableView.constant = 0;
        _hidePickerButton.alpha = 0;
        _datePicker.alpha = 0.0;
        [self.view layoutIfNeeded];
    }];
}

-(IBAction)setUserBirthDay:(UITapGestureRecognizer*)sender
{
    [self.view endEditing:YES];
    UITableViewCell * cell = (UITableViewCell*)sender.view;
    NSIndexPath * indexpath = [self.tableView indexPathForCell:cell];
    
    
    _bottomSpaceTableView.constant = _datePicker.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        
        _hidePickerButton.alpha = 1.0;
        _datePicker.alpha = 1.0;
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(IBAction)selectAvailability:(UIButton*)sender
{
    
    self.user.available_time = (AvailableTime)sender.tag;
    [self buildInterface];
    
}

-(IBAction)selectUserExperienceTime:(id)sender
{
    
    [self performSegueWithIdentifier:segue_showExperienceTime sender:nil];
    
}

-(IBAction)selectUserSkill:(id)sender
{
    
    
    [self performSegueWithIdentifier:segue_showUserSkils sender:nil];
    
}

-(IBAction)acceptOrNotTerms:(UIButton*)sender
{
    _didAgreeTermsAndConditions = !_didAgreeTermsAndConditions;
    [self buildInterface];
}

-(IBAction)readTermsAndConditions:(UIButton*)sender
{
    [self performSegueWithIdentifier:segue_showTermsAndConditions sender:nil];
    
}

-(IBAction)saveData:(id)sender
{
    NSString *errorString = [self atemptedError];
    
    
    
    if (errorString.length == 0) {
    [DataLoader registerOrEditUser:self.user withPassword:_password andUserPhoto:_userImage isEditing:_isEditing success:^(id responseObject) {
         [self.navigationController popViewControllerAnimated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    }
    
}

-(IBAction)nextStep:(id)sender
{
    //update
    [self coordinatesForAddress];
    //
    
    if (_didAgreeTermsAndConditions)
    {
        
        
       NSString *errorString = [self atemptedError];
        
        
        
        if (errorString.length == 0) {
            [DataLoader registerOrEditUser:self.user withPassword:_password andUserPhoto:_userImage isEditing:_isEditing success:^(User* responseObject) {
                [self performSegueWithIdentifier:segue_showRegistrationStep_4 sender:responseObject.userId];
                
            } fail:^(NSError *error) {
                NSLog(@"%@", error);
            }];
        }
        
        else
        {
            if (errorString.length) {
                NSError *error = [NSError errorWithDomain:appErrorDomain code:[errorString intValue] userInfo:@{@"message" : errorString}];
                [DataLoader alertUserForError:error];
            }
        }
    }
    else
    {
        NSError *error = [NSError errorWithDomain:appErrorDomain code:[appErrorDomain intValue] userInfo:@{@"message" : @"Please read and accept terms and conditions to continue"}];
        [DataLoader alertUserForError:error];
    }
}


-(NSString*)atemptedError
{
    NSString *errorString = @"";
    
    
    if (self.user.type == _individual) {
        
        if (self.user.first_name.length == 0) {
            errorString = @"Please fill first name field";
        }
        else if (self.user.last_name.length == 0) {
            errorString = @"Please fill last name field";
        }
        else if (self.user.location.address.length == 0)
        {
            errorString = @"Please fill address field";
        }
        
        //default
//        else if (self.user.location.city.length + self.user.location.country.length == 0 ) {
//            errorString = @"Please select your location";
//        }
        
        // update
        else if (self.user.location.city.length + self.user.location.country.length == 0 && _existsCoordinates) {
            errorString = @"Please select your location";
        }
        else if (self.user.zipCode.length == 0)
        {
            errorString = @"Please fill zip code field";
        }
        //
    }
    
    
    else
    {
        
        if (self.user.first_name.length == 0) {
            errorString = @"Please fill first name field";
        }
        else if (self.user.last_name.length == 0) {
            errorString = @"Please fill last name field";
        }
        else if (self.user.location.address.length == 0)
        {
            errorString = @"Please fill address field";
        }
        
        //defualt
//        else if (self.user.location.city.length + self.user.location.country.length == 0 ) {
//            errorString = @"Please select your location";
//        }
 
        //update
        else if (self.user.location.city.length + self.user.location.country.length == 0 && _existsCoordinates) {
            errorString = @"Please select your location";
        }
        //
        
        else if (self.user.skills.count == 0) {
            errorString = @"Please select your skils";
        }
        
        else if (self.user.price_min.length == 0 || self.user.price_max.length == 0) {
            errorString = @"Please add price range";
        }
        
        else if ([self.user.price_min integerValue] < 15 ||
                 [self.user.price_max integerValue] < 15 ||
                 [self.user.price_min integerValue] > 120 ||
                 [self.user.price_max integerValue] > 120)
        {
            errorString = @"Price range should be between 15 and 120";
        }
        
        
        else if ([AppUtils validatePhone:self.user.phone] == NO) {
            errorString = @"Please enter correct phone number format";
        }
        
        //default
//        else if (self.user.birthday.length == 0) {
//            errorString = @"Please select your birthday";
//        }
        
        else if (self.user.userDescriptionDetails.length == 0) {
            errorString = @"Add small description info in description field";
        }
        
        else if ([AppUtils isValidObject:_userImage] == NO) {
            errorString = @"Add a photo for your profile";
        }
    }
    
    return errorString;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:segue_showRegistrationStep_4]) {
        RegistrationStep4ViewController * step4 = segue.destinationViewController;
        step4.userId = sender;
        
    }
    
}










// update
- (void)coordinatesForAddress{
    
    
    if(self.user.location.state.length > 0 && self.user.location.city.length > 0 && self.user.location.address > 0) {
    NSString *address  = @"";
    
    
   address = [NSString stringWithFormat:@"%@ %@ %@",self.user.location.state, self.user.location.city, self.user.location.address];
    
    
    _geocoder = [CLGeocoder new];
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
            
            _existsCoordinates = NO;
            
            return;
        }
        
        if ([placemarks count] > 0) {
            _placemark = [placemarks lastObject];
            
            _existsCoordinates = YES;
            
            self.user.address_long = @(_placemark.location.coordinate.longitude);
            self.user.address_lat = @(_placemark.location.coordinate.latitude);

          //  self.user.zipCode = _placemark.postalCode;
            NSLog(@"Coordinates lat = %f, long = %f", _placemark.location.coordinate.latitude, _placemark.location.coordinate.longitude);
            
        }

    }];
    
    }
}



//- (void)selectAddress:(NSString *)city;
//{
//    _geocoder = [CLGeocoder new];
//    [_geocoder geocodeAddressString:city completionHandler:^(NSArray *placemarks, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", [error localizedDescription]);
//            return;
//        }
//
//        if ([placemarks count] > 0) {
//            _placemark = [placemarks lastObject]; // firstObject is iOS7 only.
//
//
//
//
//            if ([AppUtils isValidObject:_job])
//            {
//                _job.location.country = _placemark.addressDictionary[@"Country"];
//                _job.location.state = _placemark.addressDictionary[@"State"];
//                _job.location.city = _placemark.addressDictionary[@"City"];
//
//
//                NSArray * addressArray = _placemark.addressDictionary[@"FormattedAddressLines"];
//                _job.location.address = _job.location.address.length ? _job.location.address : [addressArray componentsJoinedByString:@", "];
//                _job.location.address = _job.location.address.length ? _job.location.address : [_job.location.city stringByAppendingFormat:@", %@",_job.location.country];
//
//                _job.longitude = @(_placemark.location.coordinate.longitude);
//                _job.lat = @(_placemark.location.coordinate.latitude);
//
//            }
//
//            else
//            {
//                self.user.location.country = _placemark.addressDictionary[@"Country"];
//                self.user.location.state = _placemark.addressDictionary[@"State"];
//                self.user.location.city = _placemark.addressDictionary[@"City"];
//                self.user.location.address = _placemark.addressDictionary[@"Thoroughfare"];
//
//                NSArray * addressArray = _placemark.addressDictionary[@"FormattedAddressLines"];
//                self.user.location.address = self.user.location.address.length ? self.user.location.address : [addressArray componentsJoinedByString:@", "];
//                self.user.location.address = self.user.location.address.length ? self.user.location.address : [self.user.location.city stringByAppendingFormat:@", %@",self.user.location.country];
//
//                self.user.address_long = @(_placemark.location.coordinate.longitude);
//                self.user.address_lat = @(_placemark.location.coordinate.latitude);
//
//                NSLog(@"%@", _placemark.addressDictionary[@"Country"]);
//                NSLog(@"%@", _placemark.addressDictionary[@"State"]);
//                NSLog(@"%@", _placemark.addressDictionary[@"City"]);
//                NSLog(@"%f", _placemark.location.coordinate.longitude);
//                NSLog(@"%f", _placemark.location.coordinate.latitude);
//                [self buildInterface];
//
//            }
//
//
//
//
//
//
//        }
//    }];
//
//
//}
//

@end
