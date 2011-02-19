//
//  ClickableTableView.m
//  Hyves
//
//  Created by Sergey on 4/6/10.
//  Copyright 2010 Hyves. All rights reserved.
//

#import "ClickableView.h"


@implementation ClickableView
@synthesize clickDelegate;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (clickDelegate!=nil)
    {
        [clickDelegate viewClicked:self];
    }
    [super touchesEnded:touches withEvent:event];
}


@end


@implementation ClickableTableView
@synthesize clickDelegate;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (clickDelegate!=nil)
    {
        [clickDelegate viewClicked:self];
    }
    [super touchesEnded:touches withEvent:event];
}


@end

@implementation ClickableLabel
@synthesize clickDelegate;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (clickDelegate!=nil)
    {
        [clickDelegate viewClicked:self];
    }
    [super touchesEnded:touches withEvent:event];
}


@end




