//
//  CoderEncrypt.h
//  VIEWS
//
//  Created by Catalin on 6/28/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CoderEncrypt)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData *)AES128DecryptWithKey:(NSString *)key;
@end
