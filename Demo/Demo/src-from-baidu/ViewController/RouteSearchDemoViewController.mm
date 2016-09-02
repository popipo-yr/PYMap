//
//  RouteSearchDemoViewController.mm
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "RouteSearchDemoViewController.h"
#import "PoiSearchDemoViewController.h"
#import "UIImage+Rotate.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

//@interface RouteAnnotation : BMKPointAnnotation
//{
//	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
//	int _degree;
//}
//
//@property (nonatomic) int type;
//@property (nonatomic) int degree;
//@end
//
//@implementation RouteAnnotation
//
//@synthesize type = _type;
//@synthesize degree = _degree;
//@end


@implementation RouteSearchDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _map = [PYMapFactory createMap];
        _mapSearcher = [PYMapSearchServiceFactory createSearcher];
        
        _map.mapDelegate = self;
        _mapSearcher.searchDelegate = self;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    _startLonText.text = @"116.397390";
    _startLatText.text = @"39.908860";
    
	_endLonText.text = @"116.307689";
	_endLatText.text = @"40.056974";
    
    UIView* mapView = [_map mapView];
    mapView.frame = self.view.bounds;
    [self.view insertSubview:mapView atIndex:0];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    PYCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake(39.905206, 116.390356);
    region.span = PYCoordinateSpanMake(0.5f, 0.5f);
    
    [_map setRegion:region animated:false];
}


#pragma mark - action

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}


- (IBAction)onClickBusSearch
{
    CLLocationCoordinate2D start = (CLLocationCoordinate2D){[_startLatText.text floatValue],
                                                            [_startLonText.text floatValue]};

    CLLocationCoordinate2D end = (CLLocationCoordinate2D){[_endLatText.text floatValue],
                                                          [_endLonText.text floatValue]};

    [_mapSearcher searchBusingRouteWithFromCoordinate:start
                                         toCoordinate:end
                                           policyType:PYBusingRoutePolicy_LeastTime
                                               atCity:@"北京"];

    NSLog(@"bus检索发送成功");
}


-(IBAction)onClickDriveSearch
{
    CLLocationCoordinate2D start = (CLLocationCoordinate2D){[_startLatText.text floatValue],
        [_startLonText.text floatValue]};
    
    CLLocationCoordinate2D end = (CLLocationCoordinate2D){[_endLatText.text floatValue],
        [_endLonText.text floatValue]};
    
    [_mapSearcher searchDrivingRouteWithFromCoordinate:start
                                          toCoordinate:end
                                            policyType:PYDrivingRoutePolicy_RealTraffic];
    NSLog(@"car检索发送成功");

}

-(IBAction)onClickWalkSearch
{
    CLLocationCoordinate2D start = (CLLocationCoordinate2D){[_startLatText.text floatValue],
        [_startLonText.text floatValue]};
    
    CLLocationCoordinate2D end = (CLLocationCoordinate2D){[_endLatText.text floatValue],
        [_endLonText.text floatValue]};
    
    [_mapSearcher searchWalkingRouteWithFromCoordinate:start
                                          toCoordinate:end];
    
    NSLog(@"walk检索发送成功");
}


#pragma mark - 私有

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

//- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
//{
//    BMKAnnotationView* view = nil;
//    switch (routeAnnotation.type) {
//        case 0:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
//                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
//                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 1:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
//                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
//                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 2:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
//                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 3:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
//                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 4:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
//                view.canShowCallout = TRUE;
//            } else {
//                [view setNeedsDisplay];
//            }
//            
//            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
//            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
//            view.annotation = routeAnnotation;
//            
//        }
//            break;
//        case 5:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
//                view.canShowCallout = TRUE;
//            } else {
//                [view setNeedsDisplay];
//            }
//            
//            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
//            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
//            view.annotation = routeAnnotation;
//        }
//            break;
//        default:
//            break;
//    }
//    
//    return view;
//}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(NSMutableArray<CLLocation* > *)locations{
    CGFloat ltX, ltY, rbX, rbY;
    if (locations.count < 1) {
        return;
    }
    CLLocationCoordinate2D pt = locations[0].coordinate;
    ltX = pt.latitude, ltY = pt.longitude;
    rbX = pt.latitude, rbY = pt.longitude;
    for (int i = 1; i < locations.count; i++) {
        CLLocationCoordinate2D pt = locations[i].coordinate;
        if (pt.latitude < ltX) {
            ltX = pt.latitude;
        }
        if (pt.latitude > rbX) {
            rbX = pt.latitude;
        }
        if (pt.longitude > ltY) {
            ltY = pt.longitude;
        }
        if (pt.longitude < rbY) {
            rbY = pt.longitude;
        }
    }
    
    PYCoordinateRegion region;
    region.center.latitude = (ltX + rbX) * 0.5f;
    region.center.longitude = (ltY + rbY) * 0.5f;
    region.span.latitudeDelta = rbX - ltX;
    region.span.longitudeDelta = ltY - rbY;
    
    [_map setRegion:region animated:false];
    [_map setZoomScale:[_map getZoomLevel] - 0.3 animated:YES];
}


#pragma mark - BMKRouteSearchDelegate

-(void)pyMapSearcher:(id<PYMapSearcherProtocal>)mapSearcher searchBusingRouteComplete:(PYBusingRouteSearchResult *)result
{
   
    [_map removeAllAnnotations];
    [_map removeAllOverlays];
    
    if (result.routes.count == 0) return;
    
    PYBusingRoutePlan* plan = result.routes.firstObject;
    
    // 计算路线方案中的路段数目
    NSInteger size = [plan.steps count];
    NSMutableArray<CLLocation* > *locations = [NSMutableArray new];
    
    for (int i = 0; i < size; i++) {
        
        PYBusingStep* transitStep = plan.steps[i];
        
        if(i==0){
            PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
            item.coordinate = transitStep.polyline.firstObject.coordinate;
            [_map addAnnotation:item imageName:@"icon_nav_start.png" uid:@"start" reuseId:@"start"]; // 添加起点标注
            
        }else if(i==size-1){
            
            PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
            item.coordinate = transitStep.polyline.lastObject.coordinate;
            [_map addAnnotation:item imageName:@"icon_nav_end.png" uid:@"end" reuseId:@"end"]; // 添加终点标注
        }
        
        PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
        item.coordinate = transitStep.polyline.firstObject.coordinate;
        [_map addAnnotation:item imageName:@"icon_nav_rail.png" uid:@"through" reuseId:@"through"]; // 添加经过点标注
        
        //轨迹点总数累计
        [locations addObjectsFromArray:transitStep.polyline];
    }

    [_map addRouteWithCoords:locations strokeColor:[UIColor redColor] lineWidth:3 uid:@"ssssss"];
   
    [self mapViewFitPolyLine:locations];
}

-(void)pyMapSearcher:(id<PYMapSearcherProtocal>)mapSearcher searchDriveRouteComplete:(PYDrivingRouteSearchResult *)result
{
    [_map removeAllAnnotations];
    [_map removeAllOverlays];
    
    if (result.routes.count == 0) return;
    
    PYDrivingRoutePlan* plan = result.routes.firstObject;
    
    // 计算路线方案中的路段数目
    NSInteger size = [plan.steps count];
    NSMutableArray<CLLocation* > *locations = [NSMutableArray new];
    
    for (int i = 0; i < size; i++) {
       
         PYDrivingStep* step = plan.steps[i];

        if(i==0){
            PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
            item.coordinate = step.polyline.firstObject.coordinate;
            [_map addAnnotation:item imageName:@"icon_nav_start.png" uid:@"start" reuseId:@"start"]; // 添加起点标注
            
        }else if(i==size-1){
            
            PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
            item.coordinate = step.polyline.lastObject.coordinate;
            [_map addAnnotation:item imageName:@"icon_nav_end.png" uid:@"end" reuseId:@"end"]; // 添加终点标注
        }
        
        PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
        item.coordinate = step.polyline.firstObject.coordinate;
        [_map addAnnotation:item imageName:@"icon_nav_waypoint.png" uid:@"through" reuseId:@"through"]; // 添加经过点标注
        
        //轨迹点总数累计
        [locations addObjectsFromArray:step.polyline];
    }
    
    [_map addRouteWithCoords:locations strokeColor:[UIColor redColor] lineWidth:3 uid:@"ssssss"];
    
    [self mapViewFitPolyLine:locations];
}

-(void)pyMapSearcher:(id<PYMapSearcherProtocal>)mapSearcher searchWalkRouteComplete:(PYWalkingRouteSearchResult *)result
{
    [_map removeAllAnnotations];
    [_map removeAllOverlays];
    
    if (result.routes.count == 0) return;
    
    PYWalkingRoutePlan* plan = result.routes.firstObject;
    
    // 计算路线方案中的路段数目
    NSInteger size = [plan.steps count];
    NSMutableArray<CLLocation* > *locations = [NSMutableArray new];
    
    
    for (int i = 0; i < size; i++) {
        
        PYWalkingStep* step = plan.steps[i];
        
        if(i==0){
            PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
            item.coordinate = step.polyline.firstObject.coordinate;
            [_map addAnnotation:item imageName:@"icon_nav_start.png" uid:@"start" reuseId:@"start"]; // 添加起点标注
            
        }else if(i==size-1){
            
            PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
            item.coordinate = step.polyline.lastObject.coordinate;
            [_map addAnnotation:item imageName:@"icon_nav_end.png" uid:@"end" reuseId:@"end"]; // 添加终点标注
        }
        
        PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
        item.coordinate = step.polyline.firstObject.coordinate;
        [_map addAnnotation:item imageName:@"icon_direction.png" uid:@"through" reuseId:@"through"]; // 添加经过点标注
        
        //轨迹点总数累计
        [locations addObjectsFromArray:step.polyline];
    }
    
    [_map addRouteWithCoords:locations strokeColor:[UIColor redColor] lineWidth:3 uid:@"ssssss"];
    
    [self mapViewFitPolyLine:locations];
}

-(void)pyMapSearcher:(id<PYMapSearcherProtocal>)mapSearcher searchFail:(NSError *)err
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                          message:err.description
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"确定",nil];
    [myAlertView show];
}




@end
