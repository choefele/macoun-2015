//
//  InterfaceController.m
//  Connectivity WatchKit Extension
//
//  Created by Claus Höfele on 13/10/15.
//  Copyright © 2015 Claus Höfele. All rights reserved.
//

#import "InterfaceController.h"

@interface InterfaceController()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (nonatomic) NSInteger counter;

@end

@implementation InterfaceController

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



