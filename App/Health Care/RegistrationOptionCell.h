//
//  RegistrationOptionCell.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//


#import <ImoDynamicTableView/ImoDynamicDefaultCell.h>
#import "AppConstants.h"

@interface RegistrationOptionCellSource : IDDCellSource
@property (nonatomic,assign) SEL individualHiringSelector;
@property (nonatomic,assign) SEL professionalCNASelector;
@property (nonatomic,assign)  ClientType clientType;
@end

@interface RegistrationOptionCell : ImoDynamicDefaultCellExtended
@property (weak, nonatomic) IBOutlet UILabel *individualTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *profesionalTitlelabel;
- (void)setUpWithSource:(RegistrationOptionCellSource*)source;
@property (weak, nonatomic) IBOutlet UIButton *individualHiringButton;
@property (weak, nonatomic) IBOutlet UIButton *professionalCNAButton;



@end

