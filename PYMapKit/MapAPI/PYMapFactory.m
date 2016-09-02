//
//  PYMapFactory.m
//
//  Created by YR on 15/8/21.
//  Copyright (c) 2015年 YR. All rights reserved.
//

#import "PYMapConfigure.h"
#import "PYMapFactory.h"
#import "PYMapApiKey.h"

#if defined(_Map_Baidu) || defined(_Search_Baidu)
#import "PYMapWithBaidu.h"
#endif

#if defined(_Map_Tencent) || defined(_Search_Tencent)
#import "PYMapWithTencent.h"
#endif

#if defined(_Map_MA) || defined(_Search_MA)
#import "PYMapWithMA.h"
#endif

#ifdef _Map_Apple
#import "PYMapWithApple.h"
#endif


@implementation PYMapFactory

/**
 *  创建地图
 */
+(id<PYMapProtocal>) createMap{
    
#ifdef _Map_Baidu
    return [[PYMapWithBaidu alloc] init];
#endif
    
#ifdef _Map_Tencent
    return [[PYMapWithTencent  alloc] init];
#endif
    
#ifdef _Map_MA
    return [[PYMapWithMA alloc] init];
#endif
    
#ifdef _Map_Apple
    return [[PYMapWithApple alloc] init];
#endif
    
    return nil;
}


/**
 *  设置apikey 和 地图服务代理
 */
+(id) startWithDelegate:(id)delegate{

    id retObj = nil;
    
#if defined(_Map_Baidu) || defined(_Search_Baidu)
    BMKMapManager* manager = [[BMKMapManager alloc] init];
    [manager start:PYMapApiKey_Baidu generalDelegate:delegate];
    retObj = manager;
#endif
    
#if defined(_Map_Tencent) || defined(_Search_Tencent)
    [QMapServices sharedServices].apiKey = PYMapApiKey_Tencent;
#endif
    
#if defined(_Map_MA) || defined(_Search_MA)
    [MAMapServices sharedServices].apiKey = PYMapApiKey_MA;
#endif
    
    return retObj;
}

/**
 *  需在开始使用前调用
 */
+(id)start{
    return  [PYMapFactory startWithDelegate:nil];
}


/**
 *  需在停止使用前调用
 */
+(void)end:(id)manager{
#if defined(_Map_Baidu) || defined(_Search_Baidu)
    if ([manager isKindOfClass:[BMKMapManager class]]) {
        [((BMKMapManager*)manager) stop];
    }
#endif
}


@end
