//
//  GeocodeDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYMapFactory.h"
#import "PYMapSearchServiceFactory.h"


@interface GeocodeDemoViewController : UIViewController<PYMapDelegate, PYMapSSKDelegate> {
	IBOutlet UITextField* _coordinateXText;
	IBOutlet UITextField* _coordinateYText;
	IBOutlet UITextField* _cityText;
	IBOutlet UITextField* _addrText;
    
    id<PYMapProtocal> _map;
    id<PYMapSearcherProtocal> _mapSearcher;
}
-(IBAction)onClickGeocode;
-(IBAction)onClickReverseGeocode;
-(IBAction)textFiledReturnEditing:(id)sender;
@end
