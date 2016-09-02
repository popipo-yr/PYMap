//
//  RouteSearchDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYMapFactory.h"
#import "PYMapSearchServiceFactory.h"

@interface RouteSearchDemoViewController : UIViewController<PYMapDelegate, PYMapSSKDelegate> {
	IBOutlet UITextField* _startLonText;
	IBOutlet UITextField* _startLatText;
	IBOutlet UITextField* _endLonText;
	IBOutlet UITextField* _endLatText;
    
    id<PYMapProtocal> _map;
    id<PYMapSearcherProtocal> _mapSearcher;
}

-(IBAction)onClickBusSearch;
-(IBAction)onClickDriveSearch;
-(IBAction)onClickWalkSearch;
-(IBAction)textFiledReturnEditing:(id)sender;


@end