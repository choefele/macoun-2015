//
//  InterfaceController.m
//  Connectivity WatchKit Extension
//
//  Created by Claus Höfele on 13/10/15.
//  Copyright © 2015 Claus Höfele. All rights reserved.
//

#import "InterfaceController.h"

#import <WatchConnectivity/WatchConnectivity.h>

@interface InterfaceController()<WCSessionDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (nonatomic) NSInteger counter;
@property (nonatomic) WCSession *session;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    if ([WCSession isSupported]) {
        self.session = [WCSession defaultSession];
        self.session.delegate = self;
        [self.session activateSession];
    }
}

- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext {
    NSNumber *counter = [applicationContext objectForKey:@"counter"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.counter = counter.integerValue;
    });
}

- (IBAction)subtract {
    self.counter--;
}

- (IBAction)add {
    self.counter++;
}

- (void)setCounter:(NSInteger)counter {
    _counter = counter;
    self.label.text = @(_counter).stringValue;
}

@end



