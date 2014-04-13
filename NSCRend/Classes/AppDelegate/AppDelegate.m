//
//  AppDelegate.m
//  NSCRend
//
//  Created by Julio Carrettoni on 3/18/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"
#import "JACTouchIndicator.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [ListViewController new];
    [self.window makeKeyAndVisible];
    [JACTouchIndicator showInWindow:self.window];
    return YES;
}

@end
