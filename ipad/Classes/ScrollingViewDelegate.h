//
//  ScrollingViewDelegate.h
//  MinesweeperFlags
//
//  Created by Judith Plasman on 04-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollingView;

@protocol ScrollingViewDelegate <NSObject>

- (void)scrollingView:(ScrollingView *)aScrollingView drawRect:(CGRect)rect;
- (void)scrollingView:(ScrollingView *)aScrollingView touchesBegan:(NSSet *)touches;
- (void)scrollingView:(ScrollingView *)aScrollingView touchesMoved:(NSSet *)touches;
- (void)scrollingView:(ScrollingView *)aScrollingView touchesEnded:(NSSet *)touches;
- (void)scrollingView:(ScrollingView *)aScrollingView touchesCancelled:(NSSet *)touches;

@end