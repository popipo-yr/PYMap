//
//  PYMapSearchServiceWithYR.m
//
//  Created by YR on 15/10/16.
//  Copyright © 2015年 YR. All rights reserved.
//

#import "PYMapConfigure.h"
#ifdef _Search_Tencent

#import "PYMapSearcherWithTencent.h"

@interface PYMapSearcherWithTencent () <QMSSearchDelegate>{
    QMSSearcher        *_mapSearcher;
}

@end

@implementation PYMapSearcherWithTencent

@synthesize searchDelegate = _searchDelegate;

- (instancetype)init
{
    if (self = [super init]) {
        _mapSearcher = [[QMSSearcher alloc] initWithDelegate:self];
    }

    return self;
}

-(void)dealloc{
    _mapSearcher.delegate = nil;
}


/*根据关键字发起检索。*/
- (void)searchPOIWithKeyword:(NSString *)keyword city:(NSString *)city
{
    QMSPoiSearchOption *poiSearchOption = [QMSPoiSearchOption new];
    
    [poiSearchOption setKeyword:keyword];
    [poiSearchOption setBoundaryByRegionWithCityName:city autoExtend:NO];
    
    [_mapSearcher searchWithPoiSearchOption:poiSearchOption];
}

/*搜步行路径*/
-(void)searchWalkingRouteWithFromCoordinate:(CLLocationCoordinate2D)from
                               toCoordinate:(CLLocationCoordinate2D)to
{
    QMSWalkingRouteSearchOption* aWRSearchOption = [QMSWalkingRouteSearchOption new];
    [aWRSearchOption setFromCoordinate:from];
    [aWRSearchOption setToCoordinate:to];
    [_mapSearcher searchWithWalkingRouteSearchOption:aWRSearchOption];
}


/*搜驾车路径*/
-(void)searchDrivingRouteWithFromCoordinate:(CLLocationCoordinate2D)from
                               toCoordinate:(CLLocationCoordinate2D)to
                                 policyType:(PYDrivingRoutePolicy)type
{
    QMSDrivingRouteSearchOption* aDriSearchOption = [QMSDrivingRouteSearchOption new];
    [aDriSearchOption setFromCoordinate:from];
    [aDriSearchOption setToCoordinate:to];
    QMSDrivingRoutePolicyType qType;
    switch (type) {
        case PYDrivingRoutePolicy_LeastDistance:
            qType = QMSDrivingRoutePolicyTypeLeastDistance;
            break;
        case PYDrivingRoutePolicy_LeastFee:
            qType = QMSDrivingRoutePolicyTypeLeastFee;
            break;
        case PYDrivingRoutePolicy_LeastTime:
            qType = QMSDrivingRoutePolicyTypeLeastTime;
            break;
        case PYDrivingRoutePolicy_RealTraffic:
            qType = QMSDrivingRoutePolicyTypeRealTraffic;
            break;
        default:
            break;
    }
    
    [aDriSearchOption setPolicyWithType:qType];
    [_mapSearcher searchWithDrivingRouteSearchOption:aDriSearchOption];
}
/*搜公交路径*/
-(void)searchBusingRouteWithFromCoordinate:(CLLocationCoordinate2D)from
                              toCoordinate:(CLLocationCoordinate2D)to
                                policyType:(PYBusingRoutePolicy)type
                                    atCity:(NSString *)city
{
    QMSBusingRouteSearchOption* aBusSearchOption = [QMSBusingRouteSearchOption new];
    [aBusSearchOption setFromCoordinate:from];
    [aBusSearchOption setToCoordinate:to];
    QMSBusingRoutePolicyType qType;
    switch (type) {
        case PYBusingRoutePolicy_LeastTime:
            qType = QMSBusingRoutePolicyTypeLeastTime;
            break;
        case PYBusingRoutePolicy_LeastTransfer:
            qType = QMSBusingRoutePolicyTypeLeastTransfer;
            break;
        case PYBusingRoutePolicy_LeastWalking:
            qType = QMSBusingRoutePolicyTypeLeastWalking;
            break;
        default:
            break;
    }
    
    [aBusSearchOption setPolicyWithType:qType];
    [_mapSearcher searchWithBusingRouteSearchOption:aBusSearchOption];
}

/*根据地址描述查坐标*/
-(void)searchCoordinateFromCity:(NSString*)city address:(NSString*)address{

    QMSGeoCodeSearchOption* aGCSearchOption = [QMSGeoCodeSearchOption new];
    if (![address hasPrefix:city]) {
        address = [NSString stringWithFormat:@"%@市%@",city,address];
    }
    aGCSearchOption.address = address;
    aGCSearchOption.region = city;
    [_mapSearcher searchWithGeoCodeSearchOption:aGCSearchOption];
}

/*根据坐标查地址描述*/
-(void)searchAddressFromCoordinate:(CLLocationCoordinate2D)coordinate{
    
    QMSReverseGeoCodeSearchOption* aGCSearchOption = [QMSReverseGeoCodeSearchOption new];
    
    [aGCSearchOption setLocationWithCenterCoordinate:coordinate];
    aGCSearchOption.get_poi = false;
    aGCSearchOption.coord_type = QMSReverseGeoCodeCoordinateTencentGoogleGaodeType;

    [_mapSearcher searchWithReverseGeoCodeSearchOption:aGCSearchOption];
}


#pragma mark - QMSSearchDelegate

- (void)searchWithSearchOption:(QMSSearchOption *)searchOption didFailWithError:(NSError *)error
{
    if ([_searchDelegate respondsToSelector:@selector(pyMapSearcher:searchFail:)]) {
        [_searchDelegate pyMapSearcher:self searchFail:error];
    }
}

- (void)searchWithPoiSearchOption:(QMSPoiSearchOption *)poiSearchOption didReceiveResult:(QMSPoiSearchResult *)poiSearchResult
{
     if ([_searchDelegate respondsToSelector:@selector(pyMapSearcher:searchPOIComplete:)]) {
        NSMutableArray *poies = [NSMutableArray array];

        for (QMSSuggestionPoiData *poiData in poiSearchResult.dataArray) {
            PYMapPoi *poi = [PYMapPoi createWithTitle:poiData.title
                                              address:poiData.address
                                             location:poiData.location];
            [poies addObject:poi];
        }

        [_searchDelegate pyMapSearcher:self searchPOIComplete:poies];
    }
}

- (void)searchWithWalkingRouteSearchOption:(QMSWalkingRouteSearchOption *)walkingRouteSearchOption
                          didRecevieResult:(QMSWalkingRouteSearchResult *)walkingRouteSearchResult
{
   if ([_searchDelegate respondsToSelector:@selector(pyMapSearcher:searchWalkRouteComplete:)]) {
        NSMutableArray *routes = [NSMutableArray new];

        for (QMSRoutePlan *aQPlan in walkingRouteSearchResult.routes) {
            PYWalkingRoutePlan *aRRPlan = [PYWalkingRoutePlan new];
            aRRPlan.distance  = aQPlan.distance;
            aRRPlan.duration  = aQPlan.duration;
            aRRPlan.direction = aQPlan.direction;
            
            NSMutableArray* PYSteps = [NSMutableArray new];
            for (QMSRouteStep* segment in aQPlan.steps) {
                if (![segment isKindOfClass:[QMSRouteStep class]]) continue;
                
                PYWalkingStep* step = [PYWalkingStep new];
                step.direction = 0;
                step.distance  = segment.distance;
                step.duration  = segment.duration;
               
                //这设计....
                NSUInteger startIndex = ((NSNumber*)segment.polyline_idx[0]).unsignedIntegerValue;
                NSUInteger endIndex   = ((NSNumber*)segment.polyline_idx[1]).unsignedIntegerValue;
               
                NSMutableArray* thePolyLine = [[NSMutableArray alloc] initWithArray:aQPlan.polyline];
                [thePolyLine removeObjectsInRange:NSMakeRange(endIndex , thePolyLine.count - endIndex)];
                [thePolyLine removeObjectsInRange:NSMakeRange(0, startIndex)];

                step.polyline  = [self _coverToCLLocationsQPolyline:thePolyLine];
                
                [PYSteps addObject:step];
            }
            
            aRRPlan.steps = PYSteps;
            
            [routes addObject:aRRPlan];
        }

        PYWalkingRouteSearchResult *result = [PYWalkingRouteSearchResult new];
        result.routes = routes;

        [_searchDelegate pyMapSearcher:self searchWalkRouteComplete:result];
    }
}


- (void)searchWithDrivingRouteSearchOption:(QMSDrivingRouteSearchOption *)drivingRouteSearchOption
                          didRecevieResult:(QMSDrivingRouteSearchResult *)drivingRouteSearchResult
{
    if ([_searchDelegate respondsToSelector:@selector(pyMapSearcher:searchDriveRouteComplete:)]) {
        NSMutableArray *routes = [NSMutableArray new];
        
        for (QMSRoutePlan *aQPlan in drivingRouteSearchResult.routes) {
            PYDrivingRoutePlan *aRRPlan = [PYDrivingRoutePlan new];
            aRRPlan.distance  = aQPlan.distance;
            aRRPlan.duration  = aQPlan.duration;
            aRRPlan.direction = aQPlan.direction;
            
            NSMutableArray* PYSteps = [NSMutableArray new];
            for (QMSRouteStep* segment in aQPlan.steps) {
                if (![segment isKindOfClass:[QMSRouteStep class]]) continue;
                
                PYDrivingStep* step = [PYDrivingStep new];
                step.direction = 0;
                step.distance  = segment.distance;
                step.duration  = segment.duration;
                
                //这设计....
                NSUInteger startIndex = ((NSNumber*)segment.polyline_idx[0]).unsignedIntegerValue;
                NSUInteger endIndex   = ((NSNumber*)segment.polyline_idx[1]).unsignedIntegerValue;
                
                NSMutableArray* thePolyLine = [[NSMutableArray alloc] initWithArray:aQPlan.polyline];
                [thePolyLine removeObjectsInRange:NSMakeRange(endIndex, thePolyLine.count - endIndex)];
                [thePolyLine removeObjectsInRange:NSMakeRange(0, startIndex)];
                
                step.polyline  = [self _coverToCLLocationsQPolyline:thePolyLine];
                
                [PYSteps addObject:step];
            }
            
            aRRPlan.steps = PYSteps;
            
            [routes addObject:aRRPlan];
        }
        
        PYDrivingRouteSearchResult *result = [PYDrivingRouteSearchResult new];
        result.routes = routes;
        
        [_searchDelegate pyMapSearcher:self searchDriveRouteComplete:result];
    }

}


- (void)searchWithBusingRouteSearchOption:(QMSBusingRouteSearchOption *)busingRouteSearchOption
                         didRecevieResult:(QMSBusingRouteSearchResult *)busingRouteSearchResult
{
    if ([_searchDelegate respondsToSelector:@selector(pyMapSearcher:searchBusingRouteComplete:)]) {
        NSMutableArray *routes = [NSMutableArray new];
        
        for (QMSBusingRoutePlan *aQPlan in busingRouteSearchResult.routes) {
            PYBusingRoutePlan *aRRPlan = [PYBusingRoutePlan new];
            aRRPlan.distance  = aQPlan.distance;
            aRRPlan.duration  = aQPlan.duration;
            
            NSMutableArray* PYSteps = [NSMutableArray new];
            for (QMSBusingSegmentRoutePlan* segment in aQPlan.steps) {
                if (![segment isKindOfClass:[QMSBusingSegmentRoutePlan class]]) continue;
              
                PYBusingStep* PYSegment = [PYBusingStep new];
                PYSegment.direction = segment.direction;
                PYSegment.distance  = segment.distance;
                PYSegment.duration  = segment.duration;
                PYSegment.polyline  = [self _coverToCLLocationsQPolyline:segment.polyline];
               
                if ([segment.mode isEqualToString:@"DRIVING"]) {
                    PYSegment.mode = PYBusingRouteStepModeType_Driving;
                }else{
                    PYSegment.mode = PYBusingRouteStepModeType_Walking;
                }
                
                [PYSteps addObject:PYSegment];
            }
            
            aRRPlan.steps = PYSteps;
            
            [routes addObject:aRRPlan];
        }
        
        PYBusingRouteSearchResult *result = [PYBusingRouteSearchResult new];
        result.routes = routes;
        
        [_searchDelegate pyMapSearcher:self searchBusingRouteComplete:result];
    }


}

-(void)searchWithGeoCodeSearchOption:(QMSGeoCodeSearchOption *)geoCodeSearchOption
                    didReceiveResult:(QMSGeoCodeSearchResult *)geoCodeSearchResult{
    
     if ([_searchDelegate respondsToSelector:@selector(pyMapSearcher:searchCoordFromAddressComplete:)]) {
         [_searchDelegate pyMapSearcher:self searchCoordFromAddressComplete:geoCodeSearchResult.location];
    }



}

- (void)searchWithReverseGeoCodeSearchOption:(QMSReverseGeoCodeSearchOption *)reverseGeoCodeSearchOption
                            didReceiveResult:(QMSReverseGeoCodeSearchResult *)reverseGeoCodeSearchResult{
    
    if ([_searchDelegate respondsToSelector:@selector(pyMapSearcher:searchAddressFromCoordComplete:)]){
        
        PYMapAddress *address = [PYMapAddress new];
        
        address.province       = reverseGeoCodeSearchResult.address_component.province;
        address.city           = reverseGeoCodeSearchResult.address_component.city;
        address.district       = reverseGeoCodeSearchResult.address_component.district;
        address.street_number  = reverseGeoCodeSearchResult.address_component.street_number;
        address.summaryAddress = reverseGeoCodeSearchResult.formatted_addresses.recommend;
        
        NSArray* split = [reverseGeoCodeSearchOption.location componentsSeparatedByString:@","];
        address.location       =  CLLocationCoordinate2DMake([split.firstObject floatValue],
                                                             [split.lastObject floatValue]);
        
        
        
        [_searchDelegate pyMapSearcher:self searchAddressFromCoordComplete:address];
    }
}


#pragma mark - helper
- (NSArray*)_coverToCLLocationsQPolyline:(NSArray*)polyline{

    NSMutableArray* points = [NSMutableArray new];
    
    for (id obj in polyline) {
        if (strcmp(@encode(CLLocationCoordinate2D), [obj objCType]) == 0) {
            CLLocationCoordinate2D coord;
            [obj getValue:&coord];
            
            CLLocation* loc = [[CLLocation alloc] initWithLatitude:coord.latitude
                                                         longitude:coord.longitude];
            [points addObject:loc];
        }
    }
    
    return points;
}

@end

#endif