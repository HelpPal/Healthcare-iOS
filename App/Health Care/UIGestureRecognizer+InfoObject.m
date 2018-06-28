//
//  UIGestureRecognizer+InfoObject.m
//  Health Care
//
//  Created by Midnight.Works iMac on 11/9/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import "UIGestureRecognizer+InfoObject.h"
#import <objc/runtime.h>

static char const * const Key = "gestKey";

@implementation UIGestureRecognizer (InfoObject)


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
