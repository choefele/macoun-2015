//
//  ViewController.m
//  Connectivity
//
//  Created by Claus Höfele on 13/10/15.
//  Copyright © 2015 Claus Höfele. All rights reserved.
//

#import "ViewController.h"

#import <WatchConnectivity/WatchConnectivity.h>

@interface ViewController()<WCSessionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) NSInteger counter;
@property (nonatomic) WCSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([WCSession isSupported]) {
        self.session = [WCSession defaultSession];
        self.session.delegate = self;
        [self.session activateSession];
    }
}

- (IBAction)subtract:(id)sender {
    self.counter--;
}

- (IBAction)add:(id)sender {
    self.counter++;
}

- (void)setCounter:(NSInteger)counter {
    _counter = counter;
    self.label.text = @(_counter).stringValue;
    NSError *error;
    [self.session updateApplicationContext:@{@"counter": @(_counter)} error:&error];
}

@end
