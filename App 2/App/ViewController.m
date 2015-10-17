//
//  ViewController.m
//  App
//
//  Created by Claus Höfele on 17.10.15.
//  Copyright © 2015 Claus Höfele. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)sendLocalNotification {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    localNotification.alertBody = @"body";
    localNotification.alertAction = @"action";
    localNotification.category = @"myCategory";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
