//
//  PYMapSearchResult.m
//
//  Created by YR on 15/10/16.
//  Copyright © 2015年 YR. All rights reserved.
//

#import "PYMapSearchResult.h"

@implementation PYMapPoi {
    NSString               *_title;
    NSString               *_address;
    CLLocationCoordinate2D _location;
}

- (instancetype)initWithTitle:(NSString *)title
                      address:(NSString *)address
                     location:(CLLocationCoordinate2D)location
{
    if (self = [super init]) {
        _title      = title;
        _address    = address;
        _location   = CLLocationCoordinate2DMake(location.latitude, location.longitude);
    }
    
    return self;
}


+ (PYMapPoi *)createWithTitle:(NSString *)title
                      address:(NSString *)address
                     location:(CLLocationCoordinate2D)location
{
    return [[PYMapPoi alloc] initWithTitle:title address:address location:location];
}


@end


@implementation PYMapAddress

@end

@implementation PYRoutePlan

@end

@implementation PYWalkingStep

@end

@implementation PYWalkingRoutePlan

@end

@implementation PYWalkingRouteSearchResult

@end

@implementation PYDrivingStep

@end

@implementation PYDrivingRoutePlan

@end

@implementation PYDrivingRouteSearchResult

@end

@implementation PYBusingStep

@end

@implementation PYBusingRoutePlan

@end

@implementation PYBusingRouteSearchResult

@end

