//
//  CreateOfferViewController.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImoDynamicTableView.h>
#import "BaseTableViewController.h"

@interface CreateOfferViewController : BaseTableViewController

@property (nonatomic,assign)  BOOL isEditing;
@property (nonatomic,strong)  User* forUser;

@end
