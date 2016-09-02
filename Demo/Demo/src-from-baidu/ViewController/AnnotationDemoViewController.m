//
//  AnnotationDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]


#import "AnnotationDemoViewController.h"


@implementation AnnotationDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _map = [PYMapFactory createMap];
    }
    return self;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    
    //设置地图缩放级别
    [_map setZoomEnabled:11];
    //初始化segment
    segment.selectedSegmentIndex=0;    
    //添加内置覆盖物
    [self addOverlayView];
    
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

//segment进行切换
- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    UISegmentedControl *tempSeg = (UISegmentedControl *)sender;
    //内置覆盖物
    if(tempSeg.selectedSegmentIndex == 0) {
        [_map removeAllAnnotations];
        //添加内置覆盖物
        [self addOverlayView];
        return;
    }
    //添加标注
    else if(tempSeg.selectedSegmentIndex == 1) {
        [_map removeAllOverlays];
        [self addPointAnnotation];
        [self addAnimatedAnnotation];
        return;
    }
}


//添加内置覆盖物
- (void)addOverlayView {
    // 添加圆形覆盖物
//    if (circle == nil) {
//        CLLocationCoordinate2D coor;
//        coor.latitude = 39.915;
//        coor.longitude = 116.404;
//        circle = [BMKCircle circleWithCenterCoordinate:coor radius:5000];
//    }
//    

    

    // 添加多边形覆盖物
//    if (polygon == nil) {
//        CLLocationCoordinate2D coords[4] = {0};
//        coords[0].latitude = 39.915;
//        coords[0].longitude = 116.404;
//        coords[1].latitude = 39.815;
//        coords[1].longitude = 116.404;
//        coords[2].latitude = 39.815;
//        coords[2].longitude = 116.504;
//        coords[3].latitude = 39.915;
//        coords[3].longitude = 116.504;
    {
        NSString* uid = @"uid1";
        
        
        NSMutableArray* coords = [NSMutableArray new];
        coords[0] = @"116.404 , 39.915";
        coords[1] = @"116.404 , 39.815";
        coords[2] = @"116.504 , 39.815";
        coords[2] = @"116.504 , 39.915";
       [_map addOverLayer:coords
              strokeColor:[UIColor redColor]
                fillColor:[UIColor clearColor]
                lineWidth:2
                      uid:uid];
        
    }


    // 添加多边形覆盖物
//    if (polygon2 == nil) {
//        CLLocationCoordinate2D coords[5] = {0};
//        coords[0].latitude = 39.965;
//        coords[0].longitude = 116.604;
//        coords[1].latitude = 39.865;
//        coords[1].longitude = 116.604;
//        coords[2].latitude = 39.865;
//        coords[2].longitude = 116.704;
//        coords[3].latitude = 39.905;
//        coords[3].longitude = 116.654;
//        coords[4].latitude = 39.965;
//        coords[4].longitude = 116.704;
//        polygon2 = [BMKPolygon polygonWithCoordinates:coords count:5];
    {
        
        NSString* uid = @"uid2";
        
        
        NSMutableArray* coords = [NSMutableArray new];
        coords[0] = @"116.604 , 39.965";
        coords[1] = @"116.604 , 39.865";
        coords[1] = @"116.704 , 39.865";
        coords[2] = @"116.654 , 39.905";
        coords[2] = @"116.704 , 39.965";
        [_map addOverLayer:coords
               strokeColor:[UIColor redColor]
                 fillColor:nil
                 lineWidth:2
                       uid:uid];
    }
}

//添加标注
- (void)addPointAnnotation
{
        PYPointAnnotation* pointAnnotation = [PYPointAnnotation new];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.915, 116.404);
       
        NSString* pointUid = @"pointUid";
        
        [_map addAnnotation:pointAnnotation
                  imageName:@"annotation_1"
                        uid:pointUid
                    reuseId:@"reuseId"];
}

// 添加动画Annotation
- (void)addAnimatedAnnotation {
    PYPointAnnotation* pointAnnotation = [PYPointAnnotation new];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.915, 116.404);
    
    NSString* pointAnimateUid = @"pointAnimateUid";
    
    [_map addAnnotation:pointAnnotation
              imageName:@"annotation_1"
                    uid:pointAnimateUid
                reuseId:@"reuseId"];
}


#pragma mark -
#pragma mark implement BMKMapViewDelegate



@end
