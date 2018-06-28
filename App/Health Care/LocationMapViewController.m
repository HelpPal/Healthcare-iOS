//
//  LocationMapViewController.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/21/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "LocationMapViewController.h"
#import <MapKit/MapKit.h>
#import "CustomPointAnnotation.h"

@interface LocationMapViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *locationMap;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewSpace;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic)  CustomPointAnnotation *tempAnnotation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;


@end

@implementation LocationMapViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"";
    
    
}
- (IBAction)back:(id)sender {
    _blurView.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    UILongPressGestureRecognizer *tapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleMapTap:)];
    tapGesture.minimumPressDuration = 0.2;
    [_locationMap addGestureRecognizer:tapGesture];
    
    
    
    
    [self.view layoutSubviews];
    // Do any additional setup after loading the view.
}


- (void)handleMapTap:(UIGestureRecognizer *)gestureRecognizer
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _bottomViewSpace.constant = -_bottomViewHeight.constant;
        [self.view layoutIfNeeded];
    }];
    
    
    CGPoint touchPoint = [gestureRecognizer locationInView:_locationMap];
    CLLocationCoordinate2D touchMapCoordinate = [_locationMap convertPoint:touchPoint toCoordinateFromView:_locationMap];
    
    
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loccation = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude]; //insert your coordinates
    
    [ceo reverseGeocodeLocation:loccation completionHandler:^(NSArray *placemarks, NSError *error) {
                  
                  if (placemarks.count) {
                      
                      NSMutableArray * arr = [NSMutableArray new];
                      
                      for (CLPlacemark *placemark in placemarks)
                      {
                          MKPlacemark *mkPlacemark = [[MKPlacemark alloc] initWithPlacemark:placemark];
                          [arr addObject:mkPlacemark];
                      }
                      [self addFoundLocationsAnootation:arr];
                  }
                  else {
                      NSLog(@"Could not locate");
                  }
              }
     ];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _bottomViewSpace.constant = -60;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:textField.text];
    
    // Create the local search to perform the search
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            [self addFoundLocationsAnootation:[response mapItems]];
        }
        else {
            NSLog(@"Search Request Error: %@", [error localizedDescription]);
        }
        
    }];
    [textField resignFirstResponder];
    return YES;
}


-(void)addFoundLocationsAnootation:(NSArray*)items
{
    [_locationMap removeAnnotations:_locationMap.annotations];
    [items enumerateObjectsUsingBlock:^(MKMapItem *mapItem, NSUInteger idx, BOOL * _Nonnull stop) {
        MKPlacemark *placemark ;
        if ([mapItem isKindOfClass:[MKMapItem class]])
        {
            placemark = [mapItem placemark];
        }
        
        else
        {
            placemark = (MKPlacemark *)mapItem;
        }
        CustomPointAnnotation *annotation = [[CustomPointAnnotation alloc] init];
        annotation.placemark = placemark;
        annotation.coordinate = placemark.location.coordinate;
        annotation.title = placemark.title;
        [_locationMap addAnnotation:annotation];
        if (idx == 0) {
            _addressLabel.text = placemark.title;
        }
        [_locationMap selectAnnotation:annotation animated:NO];
    }];
    
    [_locationMap showAnnotations:_locationMap.annotations animated:YES];
    
}



- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [UIView animateWithDuration:0.5 animations:^{
        _bottomViewSpace.constant = 0;
        [self.view layoutIfNeeded];
    }];
    
    _addressLabel.text = view.annotation.title;
    _tempAnnotation = (CustomPointAnnotation*)view.annotation;
}

- (IBAction)selectAddress:(id)sender
{
    if ([AppUtils isValidObject:_job])
    {
        _job.location.country = _tempAnnotation.placemark.addressDictionary[@"Country"];
        _job.location.state = _tempAnnotation.placemark.addressDictionary[@"State"];
        _job.location.city = _tempAnnotation.placemark.addressDictionary[@"City"];
        
        
        NSArray * addressArray = _tempAnnotation.placemark.addressDictionary[@"FormattedAddressLines"];
        _job.location.address = _job.location.address.length ? _job.location.address : [addressArray componentsJoinedByString:@", "];
        _job.location.address = _job.location.address.length ? _job.location.address : [_job.location.city stringByAppendingFormat:@", %@",_job.location.country];
        
        _job.longitude = @(_tempAnnotation.placemark.coordinate.longitude);
        _job.lat = @(_tempAnnotation.placemark.coordinate.latitude);
        

    }
    
    else
    {
        //default
//        self.user.location.country = _tempAnnotation.placemark.addressDictionary[@"Country"];
//        self.user.location.state = _tempAnnotation.placemark.addressDictionary[@"State"];
//        self.user.location.city = _tempAnnotation.placemark.addressDictionary[@"City"];
        
    
        //update
        self.user.location.country = _tempAnnotation.placemark.addressDictionary[@"Country"];
        self.user.location.city = _tempAnnotation.placemark.addressDictionary[@"City"];
                 self.user.location.state = _tempAnnotation.placemark.addressDictionary[@"State"];
        self.user.location.address = _tempAnnotation.placemark.addressDictionary[@"Thoroughfare"];
        self.user.zipCode = _tempAnnotation.placemark.postalCode;
        //
        
     NSArray * addressArray = _tempAnnotation.placemark.addressDictionary[@"FormattedAddressLines"];
        
        if(addressArray.count > 0) {
         self.user.location.address = self.user.location.address.length ? self.user.location.address : addressArray[0];
        }
      ///  self.user.location.address = self.user.location.address.length ? self.user.location.address : [addressArray componentsJoinedByString:@", "];
       // self.user.location.address = self.user.location.address.length ? self.user.location.address : [self.user.location.city stringByAppendingFormat:@", %@",self.user.location.country];
        
        self.user.address_long = @(_tempAnnotation.placemark.coordinate.longitude);
        self.user.address_lat = @(_tempAnnotation.placemark.coordinate.latitude);
    }
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [AppUtils setApplicationAppearence];
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
