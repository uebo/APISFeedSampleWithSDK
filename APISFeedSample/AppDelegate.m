//
//  AppDelegate.m
//  APISFeedSample
//
//  Created by 植田 洋次 on 2014/11/05.
//  Copyright (c) 2014年 Yoji Ueda. All rights reserved.
//

#import "AppDelegate.h"
//FIXME: SDKをインポートする
//#import <AppiariesSDK/AppiariesSDK.h>
#import "Post.h"
#import "ImageFile.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //FIXME: SDKを有効化する
//    baas.config.datastoreID = @"_sandbox";
//    baas.config.applicationID = @"APP_ID";
//    baas.config.applicationToken = @"TOKEN";
//    [baas activate];
    //FIXME: ユーザ定義クラスを登録する
//    [baas registerClasses:@[[Post class], [ImageFile class]]];
    
    // APNs: プッシュ通知機能利用登録（デバイストークン発行要求）
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
#ifdef __IPHONE_8_0
        // iOS8以降のプッシュ通知登録処理
        UIUserNotificationType types = UIUserNotificationTypeBadge |  UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *notifSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notifSettings];
#endif
    } else {
        // iOS8以前のプッシュ通知登録処理
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}
#endif

// APNs: デバイストークン発行成功時ハンドラ
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs: デバイストークン発行成功 [デバイストークン:%@]", [deviceToken description]);
    
    //FIXME: デバイストークン登録
//    ABDevice *device = [ABDevice deviceWithRawDeviceToken:deviceToken];
//    device[@"ageGroup"]       = @10;
//    device[@"gender"]         = @"female";
//    device[@"favorites"]      = @{@"brands" : @[@"Appiaries", @"BaaS"]};
//    device[@"point"]          = @0;
//    device[@"withdrawn"]      = @(NO);
//    device[@"lastAccessDate"] = [NSDate date];
//    [device register];
}

// APNs: デバイストークン発行失敗時ハンドラ
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"APNs: デバイストークン発行失敗 [原因:%@]", [error localizedDescription]);
}

@end
