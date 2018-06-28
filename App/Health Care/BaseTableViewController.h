//
//  BaseTableViewController.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/5/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "BaseViewController.h"
#import <ImoDynamicTableView/ImoDynamicTableView.h>
#import "SeparatorCell.h"
#import "SpaceCell.h"

@interface BaseTableViewController : BaseViewController

@property (nonatomic, weak) IBOutlet ImoDynamicTableView * tableView;

-(void)hideKeyboard;
@end
