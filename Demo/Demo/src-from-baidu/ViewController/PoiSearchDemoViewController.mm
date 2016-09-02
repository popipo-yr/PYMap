//
//  PoiSearchDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "PoiSearchDemoViewController.h"


@implementation PoiSearchDemoViewController


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
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

	_cityText.text = @"北京";
	_keyText.text  = @"餐厅";
    
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


-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (void)dealloc
{
}

- (IBAction)onClickOk
{
    curPage = 0;

    [_mapSearcher searchPOIWithKeyword:_keyText.text
                                  city:_cityText.text];

    NSLog(@"城市内检索发送成功");
}


#pragma mark -
#pragma mark implement BMKSearchDelegate

- (void)pyMapSearcher:(id<PYMapSearcherProtocal>)mapSearcher searchPOIComplete:(NSArray<PYMapPoi *> *)poies
{
    [_map removeAllAnnotations];

    int uid = 0;

    for (PYMapPoi *poi in poies) {
        // 生成重用标示identifier
        NSString *AnnotationViewID = @"xidanMark";

        PYPointAnnotation *point = [PYPointAnnotation new];
        point.coordinate = poi.location;

        [_map addAnnotation:point
                  imageName:@"pin_red"
                        uid:[@(uid) stringValue]
                    reuseId:AnnotationViewID];
        uid++;
    }
}



@end
