//
//  CustomPointAnnotation.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/25/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomPointAnnotation : MKPointAnnotation
@property (nonatomic, strong) MKPlacemark *placemark;
@end
