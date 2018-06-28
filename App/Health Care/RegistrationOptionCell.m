//
//  RegistrationOptionCell.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "RegistrationOptionCell.h"
#import "AppUtils.h"
@implementation RegistrationOptionCellSource

- (id)init
{
  self = [super init];
  if (self)
  {
    self.cellClass = @"RegistrationOptionCell";
  }
  return self;
}

@end


@implementation RegistrationOptionCell

- (void)setUpWithSource:(RegistrationOptionCellSource*)source
{
    [_individualHiringButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    [_professionalCNAButton removeTarget:source.target action:NULL forControlEvents:UIControlEventAllEvents];
    
    [_individualHiringButton addTarget:source.target action:source.individualHiringSelector forControlEvents:UIControlEventTouchUpInside];
    [_professionalCNAButton addTarget:source.target action:source.professionalCNASelector forControlEvents:UIControlEventTouchUpInside];
    
    [self setSelectedImageOption:source.clientType];
}


-(void)setSelectedImageOption:(ClientType)clientType
{
    if (clientType == _unknown_type) {
        return;
    }
    
    int choice = clientType;
    
    NSString * individualImageName = [@"individualHiringImage" stringByAppendingFormat:@"%d",!choice];
    NSString * professionalCNAImageName = [@"profesionalCNAImage" stringByAppendingFormat:@"%d",choice];
    
    _profesionalTitlelabel.textColor = clientType == _profesional ? [AppUtils inputFieldTextColor] : [UIColor darkTextColor];
    _individualTitlelabel.textColor = clientType == _individual ? [AppUtils inputFieldTextColor] : [UIColor darkTextColor];

    [_individualHiringButton setImage:[UIImage imageNamed:individualImageName] forState:UIControlStateNormal];
    [_individualHiringButton setImage:[UIImage imageNamed:individualImageName] forState:UIControlStateSelected];
    [_individualHiringButton setImage:[UIImage imageNamed:individualImageName] forState:UIControlStateHighlighted];
    
    [_professionalCNAButton setImage:[UIImage imageNamed:professionalCNAImageName] forState:UIControlStateNormal];
    [_professionalCNAButton setImage:[UIImage imageNamed:professionalCNAImageName] forState:UIControlStateSelected];
    [_professionalCNAButton setImage:[UIImage imageNamed:professionalCNAImageName] forState:UIControlStateHighlighted];
    
}
@end




