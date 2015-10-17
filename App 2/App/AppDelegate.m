//
//  AppDelegate.m
//  App
//
//  Created by Claus Höfele on 17.10.15.
//  Copyright © 2015 Claus Höfele. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerForNotification];
    
    return YES;
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler {
    completionHandler();
}

- (void)registerForNotification {
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.activationMode = UIUserNotificationActivationModeForeground;
    action.title = @"Action 1";
    action.identifier = @"firstButtonAction";
    
    UIMutableUserNotificationCategory *actionCategory = [[UIMutableUserNotificationCategory alloc] init];
    actionCategory.identifier = @"myCategory";
    [actionCategory setActions:@[action] forContext:UIUserNotificationActionContextDefault];
    [actionCategory setActions:@[action] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObject:actionCategory];
    UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

@end
