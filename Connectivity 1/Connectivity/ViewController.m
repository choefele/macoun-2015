//
//  ViewController.m
//  Connectivity
//
//  Created by Claus Höfele on 13/10/15.
//  Copyright © 2015 Claus Höfele. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) NSInteger counter;

@end

@implementation ViewController

- (IBAction)subtract:(id)sender {
    self.counter--;
}

- (IBAction)add:(id)sender {
    self.counter++;
}

- (void)setCounter:(NSInteger)counter {
    _counter = counter;
    self.label.text = @(_counter).stringValue;
}

@end
