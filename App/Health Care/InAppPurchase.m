//
//  InAppPurchase.m
//  Chat for WhatsApp
//
//  Created by Midnight.Works iMac on 12/1/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "InAppPurchase.h"
#import "AppUtils.h"

@implementation InAppPurchase
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _quantity = @"";
        _purchase_date_ms = @"";
        _expires_date = @"";
        _expires_date_pst = @"";
        _transaction_id = @"";
        _is_trial_period = @"";
        _original_transaction_id = @"";
        _purchase_date = @"";
        _product_id = @"";
        _original_purchase_date_pst = @"";
        _original_purchase_date_ms = @"";
        _web_order_line_item_id = @"";
        _expires_date_ms = @"";
        _purchase_date_pst = @"";
        _original_purchase_date = @"";
        _isValidPurchase = NO;
        

    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    
    if (self) {
        _quantity = dict[@"quantity"];
        _purchase_date_ms = dict[@"purchase_date_ms"];
        _expires_date = dict[@"expires_date"];
        _expires_date_pst = dict[@"expires_date_pst"];
        _transaction_id = dict[@"transaction_id"];
        _is_trial_period = dict[@"is_trial_period"];
        _original_transaction_id = dict[@"original_transaction_id"];
        _purchase_date = dict[@"purchase_date"];
        _product_id = dict[@"product_id"];
        _original_purchase_date_pst = dict[@"original_purchase_date_pst"];
        _original_purchase_date_ms = dict[@"original_purchase_date_ms"];
        _web_order_line_item_id = dict[@"web_order_line_item_id"];
        _expires_date_ms = dict[@"expires_date_ms"];
        _purchase_date_pst = dict[@"purchase_date_pst"];
        _original_purchase_date = dict[@"original_purchase_date"];
        
        
        long timeInterval = [[NSDate date] timeIntervalSince1970];
        _isValidPurchase = timeInterval < [_expires_date_ms longLongValue]/1000;
    }
    return self;
}

@end
