//
//  AppDelegate.m
//  PYMap
//
//  Created by YR on 16/4/28.
//  Copyright © 2016年 yr. All rights reserved.
//

#import "AppDelegate.h"
#import "PYMapKit.h"

@interface AppDelegate (){

    id _mapManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _mapManager = [PYMapFactory start];
    [PYMapSearchServiceFactory start];
    
    [self.window setRootViewController:_navigationController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {

    [PYMapFactory end:_mapManager];
}

@end
