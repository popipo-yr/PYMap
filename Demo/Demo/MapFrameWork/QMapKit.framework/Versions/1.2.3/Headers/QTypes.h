//
//  QType.h
//  QMap
//
//  Created by songjian on 14-8-18.
//  Copyright (c) 2014年 Tencent. All rights reserved.
//

#import "QFoundation.h"

typedef NS_ENUM(NSUInteger, QMapType) {
    QMapTypeStandard = 0,       ///<标准地图
    QMapTypeSatellite           ///<卫星地图
};

Q_EXTERN NSString * const QErrorDomain;

typedef NS_ENUM(NSUInteger, QErrorCode) {
    QErrorDataInvalid = 1,          ///<数据错误
    QErrorUnknown,          ///<未知错误
};
