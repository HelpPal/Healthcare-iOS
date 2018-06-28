//
//  UIButton+InfoObject.m
//  Health Care
//
//  Created by Midnight.Works iMac on 10/25/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "UIButton+InfoObject.h"
#import <objc/runtime.h>

static char const * const Key = "oKey";

@implementation UIButton (InfoObject)

@dynamic infoObject;


- (void)setInfoObject:(id)infoObject
{
    objc_setAssociatedObject(self, &Key, infoObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)infoObject
{
    return objc_getAssociatedObject(self, &Key);
}


-(BOOL)adjustsImageWhenHighlighted
{
    return NO;
}


@end
