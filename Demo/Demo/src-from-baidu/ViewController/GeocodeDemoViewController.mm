//
//  GeocodeDemoViewController.mm
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "GeocodeDemoViewController.h"

@interface GeocodeDemoViewController ()
{
    bool isGeoSearch;    
}
@end
@implementation GeocodeDemoViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

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
	_coordinateXText.text = @"116.403981";
	_coordinateYText.text = @"39.915101";
	_cityText.text = @"北京";
	_addrText.text = @"海淀区上地十街10号";
    
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


-(IBAction)onClickReverseGeocode
{
    isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if (_coordinateXText.text != nil && _coordinateYText.text != nil) {
        pt = (CLLocationCoordinate2D){[_coordinateYText.text floatValue], [_coordinateXText.text floatValue]};
    }
    
    [_mapSearcher searchAddressFromCoordinate:pt];
    
    NSLog(@"反geo检索发送成功");
}

-(IBAction)onClickGeocode
{
    isGeoSearch = true;
    
    [_mapSearcher searchCoordinateFromCity:_cityText.text
                                   address:_addrText.text];
    
    NSLog(@"geo检索发送成功");
}


-(void)pyMapSearcher:(id<PYMapSearcherProtocal>)mapSearcher searchAddressFromCoordComplete:(PYMapAddress *)address
{
    PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
    item.coordinate = address.location;
    
    [_map removeAllAnnotations];
    [_map addAnnotation:item imageName:@"pin_green" uid:@"uid" reuseId:@"reuseId"];
    [_map setCenterCoordinate:address.location animated:YES];
    
    NSString* titleStr;
    NSString* showmeg;
    titleStr = @"反向地理编码";
    showmeg = [NSString stringWithFormat:@"%@",address.summaryAddress];
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}


-(void)pyMapSearcher:(id<PYMapSearcherProtocal>)mapSearcher searchCoordFromAddressComplete:(CLLocationCoordinate2D)location
{
    PYPointAnnotation* item = [[PYPointAnnotation alloc]init];
    item.coordinate = location;
    
    [_map removeAllAnnotations];
    [_map addAnnotation:item imageName:@"pin_purple" uid:@"uid" reuseId:@"reuseId"];
    [_map setCenterCoordinate:location animated:YES];
 
    
    NSString* titleStr;
    NSString* showmeg;
    
    titleStr = @"正向地理编码";
    showmeg = [NSString stringWithFormat:@"纬度:%f,经度:%f",location.latitude, location.longitude];
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}


-(void)pyMapSearcher:(id<PYMapSearcherProtocal>)mapSearcher searchFail:(NSError *)err
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:err.description delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

@end
