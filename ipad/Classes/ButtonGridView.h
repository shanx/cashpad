//
//  ProductsView.h
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollingViewDelegate.h"

@protocol ButtonGridViewDelegate;

@interface ButtonGridView : UIScrollView <ScrollingViewDelegate>
{
	NSMutableArray *scrollingViews;
	CGSize buttonSize;
	NSInteger highlightedIndex;
}

@property (nonatomic, assign) IBOutlet id <ButtonGridViewDelegate> delegate;
@property (nonatomic, retain) NSArray *titles;
@property (nonatomic, assign) NSInteger rowCount;
@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, retain) UIImage *buttonImage;
@property (nonatomic, retain) UIImage *highlightedButtonImage;
@property (nonatomic, assign) CGSize buttonSize;

@end
