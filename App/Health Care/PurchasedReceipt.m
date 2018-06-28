//
//  PurchasedReceipt.m
//  Chat for WhatsApp
//
//  Created by Midnight.Works iMac on 12/1/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "PurchasedReceipt.h"
#import "InAppPurchase.h"

@implementation PurchasedReceipt
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _status = 0;
        _environment = @"";
        _receipt = [Receipt new];
        _latest_receipt_info = [NSMutableArray new];
        _latest_receipt = @"";

    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    
    if (self) {
        _status = [dict[@"status"] integerValue];
        _environment = dict[@"environment"];
        _receipt = [[Receipt new] initWithDictionary:dict[@"receipt"]];
        _latest_receipt_info = [NSMutableArray new];
        
        
        for (NSDictionary * dictionary in dict[@"latest_receipt_info"]) {
            [_latest_receipt_info addObject:[[InAppPurchase new] initWithDictionary:dictionary]];
        }
        
        
        _latest_receipt = dict[@"latest_receipt"];
    }
    return self;
}

@end
