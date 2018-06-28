//
//  AddNewJobViewController.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImoDynamicTableView.h>
#import "BaseTableViewController.h"

@interface AddNewJobViewController : BaseTableViewController

@property (nonatomic,assign)  BOOL isEditing;
@property (retain, nonatomic)  Job *jobToEdit;

@end
