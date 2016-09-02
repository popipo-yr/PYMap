//
//  ViewController.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-3-21.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _demoNameArray = [[NSArray alloc]initWithObjects:
                      @"UI控制功能-MapViewUISettingDemo",
					  @"覆盖物功能-AnnotationDemo",
					  @"POI搜索功能-PoiSearchDemo",
                      @"地理编码功能-GeocodeDemo",
					  @"路径规划功能-RouteSearchDemo",
					  nil];
    _viewControllerTitleArray = [[NSArray alloc]initWithObjects:
                                 @"UI控制功能",
                                 @"覆盖物功能",
                                 @"POI搜索功能",
                                 @"地理编码功能",
                                 @"路径规划功能",
                                 nil];
    
    _viewControllerArray = [[NSArray alloc]initWithObjects:
                            @"MapViewUISettingDemoViewController",
                            @"AnnotationDemoViewController",
                            @"PoiSearchDemoViewController",
                            @"GeocodeDemoViewController",
                            @"RouteSearchDemoViewController",
                            nil];
	self.title = [NSString stringWithFormat: @"PYMapKit Demo"];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
}

#pragma mark -
#pragma mark Table view data source


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _demoNameArray.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BaiduMapApiDemoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_demoNameArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController* viewController = nil;
    if (indexPath.row < 19 && indexPath.row != 12) {
        viewController = [[NSClassFromString([_viewControllerArray objectAtIndex:indexPath.row]) alloc] init];
    } else {
        viewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:[_viewControllerArray objectAtIndex:indexPath.row]];
    }
    viewController.title = [_viewControllerTitleArray objectAtIndex:indexPath.row];
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
    customLeftBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
