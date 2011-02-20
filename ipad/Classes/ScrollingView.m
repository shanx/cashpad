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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[delegate scrollingView:self touchesBegan:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[delegate scrollingView:self touchesMoved:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[delegate scrollingView:self touchesEnded:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[delegate scrollingView:self touchesCancelled:touches];
}

- (void)drawRect:(CGRect)rect
{
	[delegate scrollingView:self drawRect:rect];
}

- (void)dealloc {
    [super dealloc];
}


@end
