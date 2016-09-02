//
//  PYMapSearchServiceFactory.m
//
//  Created by yr on 16/5/3.
//  Copyright © 2016年 yr. All rights reserved.
//

#import "PYMapConfigure.h"
#import "PYMapSearchServiceFactory.h"
#import "PYMapApiKey.h"

#ifdef _Search_Tencent
#import "PYMapSearcherWithTencent.h"
#endif

#ifdef _Search_MA
#import "PYMapSearcherWithMA.h"
#endif

#ifdef _Search_Baidu
#import "PYMapSearcherWithBaidu.h"
#endif


@implementation PYMapSearchServiceFactory

+ (id<PYMapSearcherProtocal>)createSearcher
{
#ifdef _Search_Tencent
    return [[PYMapSearcherWithTencent alloc] init];
#endif
    
#ifdef _Search_MA
    return [[PYMapSearcherWithMA alloc] init];
#endif

#ifdef _Search_Baidu
    return [[PYMapSearcherWithBaidu alloc] init];
#endif
    
    return nil;
}


+ (id)start
{
#ifdef _Search_Tencent
    [[QMSSearchServices sharedServices] setApiKey:PYMapApiKey_Tencent];
#endif
    
#ifdef _Search_MA
    [[AMapSearchServices sharedServices] setApiKey:PYMapApiKey_MA];
#endif
    
    
    return nil;
}


@end
