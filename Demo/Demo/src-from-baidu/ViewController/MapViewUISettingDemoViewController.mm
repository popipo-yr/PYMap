//
//  MapViewUISettingDemoViewController.m
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "MapViewUISettingDemoViewController.h"

@implementation MapViewUISettingDemoViewController
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _map = [PYMapFactory createMap];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
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




#pragma mark 底图手势开关

- (IBAction)zoomSwitchAction:(UISwitch *)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    [_map setZoomEnabled:[tempSwitch isOn]];
}

- (IBAction)moveSwitchAction:(UISwitch *)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    [_map setScrollEnabled:[tempSwitch isOn]];
}


@end
