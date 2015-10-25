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
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *image;
@property (nonatomic) NSInteger counter;
@property (nonatomic) WCSession *session;
@property (nonatomic) NSURLSessionDataTask *dataTask;

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

- (void)willActivate
{
    [super willActivate];

    // Based on WWDC 2015 Session 228
    if (self.dataTask == nil || self.dataTask.state != NSURLSessionTaskStateRunning) {
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:@"https://httpbin.org/delay/1"];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [self askForAssertionWithSemaphore:semaphore];

        self.dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSInteger statusCode = httpResponse.statusCode;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                self.counter = statusCode;
                [self releaseAssertionWithSemaphore:semaphore];
            });
        }];
        [self.dataTask resume];
    }
}

- (void)didDeactivate {
    [super didDeactivate];
}

- (void)askForAssertionWithSemaphore:(dispatch_semaphore_t)semaphore {
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    [processInfo performExpiringActivityWithReason:@"Network request" usingBlock:^(BOOL expired) {
        if (expired) {
            [self releaseAssertionWithSemaphore:semaphore];
        } else {
            dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 30 * NSEC_PER_SEC);
            dispatch_semaphore_wait(semaphore, timeout);
        }
    }];
}

- (void)releaseAssertionWithSemaphore:(dispatch_semaphore_t)semaphore {
    dispatch_semaphore_signal(semaphore);
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



