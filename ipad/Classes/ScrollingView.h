//
//  ScrollingView.h
//  MinesweeperFlags
//
//  Created by Judith Plasman on 04-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollingViewDelegate;

@interface ScrollingView : UIView
{
	
}

@property (nonatomic, assign) id <ScrollingViewDelegate> delegate;

@end
