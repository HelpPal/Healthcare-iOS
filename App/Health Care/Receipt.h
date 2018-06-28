//
//  Receipt.h
//  Chat for WhatsApp
//
//  Created by Midnight.Works iMac on 12/1/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Receipt : NSObject


@property (nonatomic, strong) NSString* receipt_type;
@property (nonatomic, strong) NSNumber* app_item_id;
@property (nonatomic, strong) NSString* receipt_creation_date;
@property (nonatomic, strong) NSString* bundle_id;
@property (nonatomic, strong) NSString* original_purchase_date;
@property (nonatomic, strong) NSMutableArray*  in_app;
@property (nonatomic, strong) NSString* adam_id;
@property (nonatomic, strong) NSString* receipt_creation_date_pst;
@property (nonatomic, strong) NSString* request_date;
@property (nonatomic, strong) NSString* request_date_pst;
@property (nonatomic, strong) NSNumber* version_external_identifier;
@property (nonatomic, strong) NSString* request_date_ms;
@property (nonatomic, strong) NSString* original_purchase_date_pst;
@property (nonatomic, strong) NSString* application_version;
@property (nonatomic, strong) NSString* original_purchase_date_ms;
@property (nonatomic, strong) NSString* receipt_creation_date_ms;
@property (nonatomic, strong) NSString* original_application_version;
@property (nonatomic, strong) NSNumber* download_id;


- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end
