//
//  Receipt.m
//  Chat for WhatsApp
//
//  Created by Midnight.Works iMac on 12/1/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "Receipt.h"
#import "InAppPurchase.h"


@implementation Receipt
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _receipt_type = @"";
        _app_item_id = @(-1);
        _receipt_creation_date = @"";
        _bundle_id = @"";
        _original_purchase_date = @"";
        _in_app = [NSMutableArray new];
        _adam_id = @"";
        _receipt_creation_date_pst = @"";
        _request_date = @"";
        _request_date_pst = @"";
        _version_external_identifier = @(-1);
        _request_date_ms = @"";
        _original_purchase_date_pst = @"";
        _application_version = @"";
        _original_purchase_date_ms = @"";
        _receipt_creation_date_ms = @"";
        _original_application_version = @"";
        _download_id = @(-1);
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    
    if (self) {
        _receipt_type = dict[@"receipt_type"];
        _app_item_id = dict[@"app_item_id"];
        _receipt_creation_date = dict[@"receipt_creation_date"];
        _bundle_id = dict[@"bundle_id"];
        _original_purchase_date = dict[@"original_purchase_date"];
        
        
        _in_app = [NSMutableArray new];
        
        for (NSDictionary * dictionary in dict[@"in_app"]) {
            [_in_app addObject:[[InAppPurchase new] initWithDictionary:dictionary]];
        }
        
        
        _adam_id = dict[@"adam_id"];
        _receipt_creation_date_pst = dict[@"receipt_creation_date_pst"];
        _request_date = dict[@"request_date"];
        _request_date_pst = dict[@"request_date_pst"];
        _version_external_identifier = dict[@"version_external_identifier"];
        _request_date_ms = dict[@"request_date_ms"];
        _original_purchase_date_pst = dict[@"original_purchase_date_pst"];
        _application_version = dict[@"application_version"];
        _original_purchase_date_ms = dict[@"original_purchase_date_ms"];
        _receipt_creation_date_ms = dict[@"receipt_creation_date_ms"];
        _original_application_version = dict[@"original_application_version"];
        _download_id = dict[@"download_id"];
    }
    return self;
}


@end
