//
//  AppDelegate.h
//  X-Share
//
//  Created by Sifon on 10/02/2015.
//  Copyright (c) 2015 4sim3. All rights reserved.
//
#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"
#import <UIKit/UIKit.h>


@interface AppDelegate : NSObject <UIApplicationDelegate> {
    GCDWebServer* _webServer;
}



@property (strong, nonatomic) UIWindow *window;


@end

