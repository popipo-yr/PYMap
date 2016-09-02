//
//  BMK+Add.m
//
//  Created by YR on 15/9/18.
//  Copyright © 2015年 YR. All rights reserved.
//

#import "PYMapConfigure.h"
#ifdef _Map_Baidu

#import "BMK+Add.h"
#import <objc/runtime.h>

@implementation BMKShape (ADD_UID)


- (void)set_uid_:(NSString *)_uid_
{
    objc_setAssociatedObject(self, @selector(_uid_), _uid_,
                             OBJC_ASSOCIATION_RETAIN);
}


- (NSString *)_uid_
{
    return objc_getAssociatedObject(self, @selector(_uid_));
}


@end



@implementation BMKMapView  (ADD)

+ (void)load
{
    Method oldMove = class_getInstanceMethod([self class],
                                             @selector(didMoveToWindow));
    Method newMove = class_getInstanceMethod([self class],
                                             @selector(newDidMoveToWindow));
    method_exchangeImplementations(oldMove, newMove);
}


- (void)newDidMoveToWindow
{
    [self newDidMoveToWindow];
    
    if (self.window == nil) {
        [self viewWillDisappear];
    } else {
        [self viewWillAppear];
    }
}


@end

#endif