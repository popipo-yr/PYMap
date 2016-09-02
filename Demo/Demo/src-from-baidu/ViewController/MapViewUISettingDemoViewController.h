//
//  MapViewUISettingDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYMapFactory.h"

@interface MapViewUISettingDemoViewController :  UIViewController{
    
    id<PYMapProtocal> _map;
    
    IBOutlet UISwitch *_zoomSwitch;
    IBOutlet UISwitch *_moveSwitch;    
    
}
- (IBAction)zoomSwitchAction:(UISwitch *)sender;
- (IBAction)moveSwitchAction:(UISwitch *)sender;

@end
