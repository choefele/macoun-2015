//
//  SecondPageController.m
//  Upgrade
//
//  Created by Claus Höfele on 12/10/15.
//  Copyright © 2015 Claus Höfele. All rights reserved.
//

#import "SecondPageController.h"

@interface SecondPageController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *label;

@end

@implementation SecondPageController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [self.label setText:@"Updated Label"];
}

@end
