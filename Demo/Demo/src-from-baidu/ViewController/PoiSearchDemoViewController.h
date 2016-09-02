//
//  PoiSearchDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PYMapFactory.h"
#import "PYMapSearchServiceFactory.h"

@interface PoiSearchDemoViewController : UIViewController<PYMapDelegate, PYMapSSKDelegate> {
	IBOutlet UITextField* _cityText;
	IBOutlet UITextField* _keyText;
    int curPage;
    
    
    id<PYMapProtocal> _map;
    id<PYMapSearcherProtocal> _mapSearcher;
}

-(IBAction)onClickOk;
-(IBAction)textFiledReturnEditing:(id)sender;
@end
