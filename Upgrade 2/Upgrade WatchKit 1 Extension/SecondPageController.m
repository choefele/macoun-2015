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
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;

@end

@implementation SecondPageController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [self.label setText:@"Updated Label"];
}

- (void)willActivate
{
    [super willActivate];

    [self animateWithDuration:0.5 animations:^{
        [self.label setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentRight];
    }];

    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index <= 100; index++) {
        NSString *imageName = [NSString stringWithFormat:@"single%dsuffix", index];
        WKImage *image = [WKImage imageWithImageName:imageName];
        WKPickerItem *item = [[WKPickerItem alloc] init];
        item.caption = imageName;
        item.contentImage = image;
        [items addObject:item];
    }
    [self.picker setItems:items];
}

@end
