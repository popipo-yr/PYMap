//
//  AnnotationDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYMapFactory.h"

@interface AnnotationDemoViewController : UIViewController {
    id<PYMapProtocal> _map;
    IBOutlet UISegmentedControl* segment;
}

@end
