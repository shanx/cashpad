//
//  ScrollingView.m
//  MinesweeperFlags
//
//  Created by Judith Plasman on 04-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScrollingView.h"
#import "ScrollingViewDelegate.h"

@implementation ScrollingView

@synthesize delegate;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint locationOfTouch = [touch locationInView:self];
	[delegate scrollingView:self pointTapped:locationOfTouch];
}

- (void)drawRect:(CGRect)rect
{
	[delegate scrollingView:self drawRect:rect];
}

- (void)dealloc {
    [super dealloc];
}


@end
