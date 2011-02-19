//
//  ProductsView.m
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import "ButtonGridView.h"
#import "ButtonGridViewDelegate.h"
#import "ScrollingView.h"

@interface ButtonGridView ()

- (void)setUp;
- (void)setUpScrollingViews;

@end

@implementation ButtonGridView

@synthesize delegate;
@synthesize titles;
@synthesize rowCount;
@synthesize columnCount;
@synthesize buttonImage;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		[self setUp];
		
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self setUp];
	}
	
	return self;
}

- (void)setUp
{
	self.pagingEnabled = YES;
	self.showsVerticalScrollIndicator = NO;
	self.showsHorizontalScrollIndicator = NO;
	scrollingViews = [[NSMutableArray alloc] init];
}

- (void)setTitles:(NSArray *)theTitles
{
	if (titles == theTitles) {
		return;
	}
	
	[theTitles retain];
	[titles release];
	theTitles = titles;
	
	[self setUpScrollingViews];
}

- (void)setUpScrollingViews
{
	for (ScrollingView *scrollingView in scrollingViews) {
		[scrollingView removeFromSuperview];
	}
	[scrollingViews removeAllObjects];
	
	NSInteger buttonCount = [titles count];
	NSInteger buttonsPerPage = rowCount * columnCount;
	NSInteger numberOfPages = floor(buttonCount / buttonsPerPage);
	
	for (NSInteger i = 0; i < numberOfPages; i++) {
		CGFloat x = i * self.bounds.size.width;
		CGFloat y = 0.0;
		CGFloat width = self.bounds.size.width;
		CGFloat height = self.bounds.size.height;
		CGRect frame = CGRectMake(x, y, width, height);
		ScrollingView *scrollingView = [[ScrollingView alloc] initWithFrame:frame];
		scrollingView.delegate = self;
		
		[scrollingViews addObject:scrollingView];
		[self addSubview:scrollingView];
		[scrollingView release];
	}
}

- (void)scrollingView:(ScrollingView *)aScrollingView drawRect:(CGRect)rect
{
	NSInteger index = [scrollingViews indexOfObject:aScrollingView];
	
	UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
	
	CGFloat horizontalMargin = (self.bounds.size.width - buttonImage.size.width);
	
	for (NSInteger i = index; i < index + rowCount * columnCount; i++) {
		if (i >= [scrollingViews count]) {
			break;
		}
		
		NSString *title = [titles objectAtIndex:i];
		
		CGSize titleSize = [title sizeWithFont:titleFont];
		
		
		
		
	}
}

- (void)scrollingView:(ScrollingView *)aScrollingView pointTapped:(CGPoint)point
{
	DLog(@"%f, %f", point.x, point.y);
}



- (void)dealloc {
    [super dealloc];
}


@end
