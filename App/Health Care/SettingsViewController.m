//
//  SettingsViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "SettingsViewController.h"
#import "SpaceCell.h"
#import "BlueButtonRoundedCell.h"
#import "InputFieldCell.h"
#import "MultiLineStringCell.h"
#import "DataSelectorCell.h"
#import "LocationMapViewController.h"

@import CoreLocation;
@interface SettingsViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate>

@property (nonatomic, retain) NSString* createNewPassword;
@property (nonatomic, retain) NSString* repeatNewPassword;
@property (nonatomic, retain) NSString* oldPassword;
@property (nonatomic, strong) User* tempUser;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *placemark;
@property (assign, nonatomic) BOOL existsCoordinates;
@end

@implementation SettingsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    _createNewPassword = @"";
    _repeatNewPassword = @"";
    _oldPassword = @"";
    
    
    [DataLoader individualUserProfile:self.user.userId  myuserid:self.user.userId success:^(User *user) {
        _tempUser = [[User new] initWithDictionary:[user dictionaryRepresentation]];
        [self buildInterface];
    } fail:^(NSError *error) {
        
    }];
}
    //_tempUser = [[User new] initWithDictionary:[self.user dictionaryRepresentation]];
    


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Settings";
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
  
    
    NSArray *fieldNames = @[ @"First name" ,
                             @"Last name",
                             @"Address",
                             @"City"
                          
                             ];
    
//    NSArray *inputStrings = @[_tempUser.first_name ,
//                              _tempUser.last_name,
//                              _tempUser.location.address
//                              ];
//
    if (_tempUser.type == _individual)
    {
        
        
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
            cellSource.inputText = _tempUser.first_name;
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
            cellSource.inputText = _tempUser.last_name;
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
            DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
            cellSource.selector = @selector(selectUserLocationCoordinates);
            
            cellSource.isMapType = YES;
            cellSource.textFieldTag = 991;
            cellSource.inputText = _tempUser.location.address;
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
            cellSource.inputText = _tempUser.location.city;
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
            cellSource.inputText = _tempUser.location.country;
            if(cellSource.inputText.length == 0)
            {
                cellSource.inputText  =  _tempUser.location.state;
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
            cellSource.inputText = _tempUser.zipCode;
            cellSource.target = self;
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
            cellSource.inputText = [_tempUser.phone isEqualToString:@""] ? @"+1" : _tempUser.phone;
            cellSource.target = self;
              [section addObject:cellSource];
        
        }
        
//        for (int i = 0; i < fieldNames.count; i++)
//        {
//            {
//                MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
//                cellSource.infoText = fieldNames[i];
//                cellSource.fontSize = 18;
//                cellSource.textAlignment = NSTextAlignmentLeft;
//                [section addObject:cellSource];
//            }
//            {
//                SpaceCellSource *cellSource = [SpaceCellSource new];
//                cellSource.staticHeightForCell = 3;
//                [section addObject:cellSource];
//            }
//            if (i == fieldNames.count - 1) {
//                {
//                    DataSelectorCellSource *cellSource = [DataSelectorCellSource new];
//                    cellSource.selector = @selector(selectUserLocationCoordinates);
//                    cellSource.buttonTitle = _tempUser.location.country.length ? [_tempUser.location.city stringByAppendingFormat:@", %@",_tempUser.location.country] :   @"Location...";
//                    cellSource.target = self;
//                    cellSource.enabled = _tempUser.location.country.length;
//                    [section addObject:cellSource];
//                }
//            }
//
//            else
//            {
//                InputFieldCellSource *cellSource = [InputFieldCellSource new];
//                cellSource.target = self;
//                cellSource.inputText = inputStrings[i];
//                cellSource.inputText = cellSource.inputText.length ? cellSource.inputText : [_tempUser.location.city stringByAppendingFormat:@", %@",_tempUser.location.country];
//                cellSource.textFieldTag = (i + 1) * 10;
//                [section addObject:cellSource];
//            }
//
//            {
//                SpaceCellSource *cellSource = [SpaceCellSource new];
//                cellSource.staticHeightForCell = 7;
//                [section addObject:cellSource];
//            }
//        }
//
//
//
//
//
//        {
//            SpaceCellSource *cellSource = [SpaceCellSource new];
//            cellSource.staticHeightForCell = 35;
//            [section addObject:cellSource];
//        }
//        {
//            SeparatorCellSource *cellSource = [SeparatorCellSource new];
//            [section addObject:cellSource];
//        }
//
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 35;
            [section addObject:cellSource];
        }
    }
    
    
    
    fieldNames = @[ @"Change password" ,
                    @"Repeat new password",
                    @"Old password"
                    ];

    for (int i = 0; i < fieldNames.count; i++)
    {
        {
            MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
            cellSource.infoText = fieldNames[i];
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
            cellSource.inputType = _keyForm;
            cellSource.textFieldTag = i;
            cellSource.target = self;
            [section addObject:cellSource];
        }
        
        {
            SpaceCellSource *cellSource = [SpaceCellSource new];
            cellSource.staticHeightForCell = 20;
            [section addObject:cellSource];
        }
    }
    
    {
        SpaceCellSource *cellSource = [SpaceCellSource new];
        cellSource.staticHeightForCell = 5;
        [section addObject:cellSource];
    }
   
    {
        MultiLineStringCellSource *cellSource = [MultiLineStringCellSource new];
        cellSource.infoText = @"Leave password fields blank if you don’t want to change the password.";
        cellSource.fontSize = 16;
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
        cellSource.selector =  @selector(saveData:);
        cellSource.padding = 100;
        cellSource.buttonTitle = @"Save";
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


-(void)selectUserLocationCoordinates
{
    [self.navigationController setNavigationBarHidden:YES];
    [self performSegueWithIdentifier:segue_showLocationMap sender:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger tag = textField.tag;
    switch (tag) {
        case 0:
            _tempUser.first_name = textField.text;
            break;
        case 1:
            _tempUser.last_name = textField.text;
            
            break;
        case 2:
            //            self.user.location.address = textField.text;
            break;
            
        case 3:
            _tempUser.phone = textField.text;
            break;
            
        case 100:
            
            _tempUser.price_min = textField.text;
            break;
            
        case 101:
            
           _tempUser.price_max = textField.text;
            break;
            
            
            
            // update
        case 991:
        {
            _tempUser.location.address = textField.text;
            [self coordinatesForAddress];
        }
            break;
            
        case 992:
        {
            _tempUser.location.city = textField.text;
            
            [self coordinatesForAddress];
        }
            break;
            
        case 993:
            _tempUser.location.state = textField.text;
            [self coordinatesForAddress];
            break;
            
        case 994:
          _tempUser.zipCode = textField.text;
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
           _tempUser.first_name = textField.text;
            break;
        case 1:
           _tempUser.last_name = textField.text;
            
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
           _tempUser.location.address = textField.text;
            
        }
            break;
            
        case 992:
        {
            _tempUser.location.city = textField.text;
            
            
        }
            break;
            
        case 993:
            _tempUser.location.state = textField.text;
            
            break;
            
        case 994:
           _tempUser.zipCode = textField.text;
            break;
            //
            
            
        default:
            break;
    }
    
}



-(IBAction)saveData:(id)sender
{
 
   
    NSString *errorString = @"";
    
        [self coordinatesForAddress];
    
    if (_tempUser.type == _individual) {
        
        if (_tempUser.first_name.length == 0) {
            errorString = @"Please fill first name field";
        }
        else if (_tempUser.last_name.length == 0) {
            errorString = @"Please fill last name field";
        }
        else if (_tempUser.location.address.length == 0)
        {
            errorString = @"Please fill address field";
        }
        
        else if (_tempUser.location.city.length + _tempUser.location.country.length == 0 ) {
            errorString = @"Please select your location";
        }
    }
    
    if (_createNewPassword.length < 6 && _createNewPassword.length > 0) {
        errorString = @"Password must have at least 6 characters";
    }
    
    else if ([_createNewPassword isEqualToString: _repeatNewPassword] == NO) {
        errorString = @"Password fields does not match";
    }
    
    
    if (errorString.length) {
        
        NSError *error = [NSError errorWithDomain:appErrorDomain code:0 userInfo:@{@"message" : errorString}];
        [DataLoader alertUserForError:error];
        return;
    }
    
    [DataLoader changeUserPassword:_oldPassword newPassword:_createNewPassword forUser:_tempUser.userId success:^(id responseObject) {
        
        if (_tempUser.type == _individual) {
            
            self.user = _tempUser;
            
            [DataLoader registerOrEditUser:_tempUser withPassword:_createNewPassword andUserPhoto:[UIImage new] isEditing:YES success:^(id responseObject) {
               
                   self.user = responseObject;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                         [self.navigationController popViewControllerAnimated:YES];
                });
                
                
                
           
            } fail:^(NSError *error) {
                
            }];
        }
        
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:segue_showLocationMap]) {
        LocationMapViewController * map = segue.destinationViewController;
        map.user = _tempUser;
        
    }
}

- (void)coordinatesForAddress{
    
    
    if(_tempUser.location.state.length > 0 && _tempUser.location.city.length > 0 && _tempUser.location.address > 0) {
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
                
               _tempUser.address_long = @(_placemark.location.coordinate.longitude);
               _tempUser.address_lat = @(_placemark.location.coordinate.latitude);
                
                //  self.user.zipCode = _placemark.postalCode;
                NSLog(@"Coordinates lat = %f, long = %f", _placemark.location.coordinate.latitude, _placemark.location.coordinate.longitude);
                
            }
            
        }];
        
    }
}

@end
