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
- (CGRect)rectForButtonAtIndex:(NSInteger)index;

@end

@implementation ButtonGridView

@synthesize delegate;
@synthesize titles;
@synthesize rowCount;
@synthesize columnCount;
@synthesize buttonImage;
@synthesize buttonSize;

- (id)initWithFrame:(CGRect)frame
{    
	DLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		[self setUp];
		
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	DLog(@"");
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self setUp];
	}
	
	return self;
}

- (void)setUp
{
	DLog(@"");
	highlightedIndex = NSNotFound;
	self.delaysContentTouches = NO;
	self.pagingEnabled = YES;
	self.showsVerticalScrollIndicator = NO;
	self.showsHorizontalScrollIndicator = NO;
	self.alwaysBounceHorizontal = YES;
	scrollingViews = [[NSMutableArray alloc] init];
}

- (void)setTitles:(NSArray *)theTitles
{
	if (titles == theTitles) {
		return;
	}
	
	[theTitles retain];
	[titles release];
	titles = theTitles;
	
	[self setUpScrollingViews];
}

- (void)setUpScrollingViews
{
	DLog(@"");
	for (ScrollingView *scrollingView in scrollingViews) {
		[scrollingView removeFromSuperview];
	}
	[scrollingViews removeAllObjects];
	
	NSInteger buttonCount = [titles count];
	NSInteger buttonsPerPage = rowCount * columnCount;
	NSInteger numberOfPages = ceil((float) buttonCount / buttonsPerPage);
	
	DLog(@"buttonCount:%d buttonsPerPage:%d numberOfPages:%d", buttonCount, buttonsPerPage, numberOfPages);
	
	for (NSInteger i = 0; i < numberOfPages; i++) {
		DLog(@"creating scrolling view");
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
	
	self.contentSize = CGSizeMake(numberOfPages * self.bounds.size.width, self.bounds.size.height);
}

- (void)scrollingView:(ScrollingView *)aScrollingView drawRect:(CGRect)rect
{
	[[UIColor whiteColor] set];
	UIRectFill(rect);
	DLog(@"rect: %d", [NSValue valueWithCGRect:rect]);
	NSInteger pageIndex = [scrollingViews indexOfObject:aScrollingView];
	
	DLog(@"drawing scrollview %d", index);
	
	UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
	
	CGFloat horizontalMargin = (self.bounds.size.width - buttonSize.width * columnCount) / (columnCount + 1);
	CGFloat verticalMargin = (self.bounds.size.height - buttonSize.height * rowCount) / (rowCount + 1);
	
	DLog(@"horizontalMargin:%f verticalMargin:%f", horizontalMargin, verticalMargin);
	
	NSInteger buttonsPerPage = rowCount * columnCount;
	
	DLog(@"buttonsPerPage:%d", buttonsPerPage);
	
	for (NSInteger i = 0; i < buttonsPerPage; i++) {
		NSInteger index = i + pageIndex * buttonsPerPage;
		if (index >= [titles count]) {
			break;
		}
		
		DLog(@"i:%d highlightedIndex:%d", i, highlightedIndex);
		
		if (index == highlightedIndex) {
			
			[[UIColor redColor] set];
			UIRectFill([self rectForButtonAtIndex:i]);
		}
		
		NSString *title = [titles objectAtIndex:i];
		
		CGSize titleSize = [title sizeWithFont:titleFont];
		
		NSInteger row = floor(i / columnCount);
		NSInteger column = i % columnCount;
		
		CGFloat x = (column + 1) * horizontalMargin + (column + 0.5) * buttonSize.width - titleSize.width / 2.0;
		CGFloat y = (row + 1) * verticalMargin + (row + 0.5) * buttonSize.height - titleSize.height / 2.0;
		
		[[UIColor blackColor] set];
		[title drawAtPoint:CGPointMake(x, y) withFont:titleFont];		
	}
}

- (void)scrollingView:(ScrollingView *)aScrollingView touchesBegan:(NSSet *)touches
{
	UITouch *touch = [touches anyObject];
	CGPoint locationOfTouch = [touch locationInView:aScrollingView];
	
	for (NSInteger i = 0; i < rowCount * columnCount; i++) {
		if (CGRectContainsPoint([self rectForButtonAtIndex:i], locationOfTouch)) {
			NSInteger pageIndex = [scrollingViews indexOfObject:aScrollingView];
			highlightedIndex = pageIndex * rowCount * columnCount + i;
			[aScrollingView setNeedsDisplay];
			DLog(@"index: %d", i);
			break;
		}
	}
}

- (void)scrollingView:(ScrollingView *)aScrollingView touchesCancelled:(NSSet *)touches
{
	highlightedIndex = NSNotFound;
	[aScrollingView setNeedsDisplay];
}

- (void)scrollingView:(ScrollingView *)aScrollingView touchesMoved:(NSSet *)touches
{
	
}

- (void)scrollingView:(ScrollingView *)aScrollingView touchesEnded:(NSSet *)touches
{
	if (highlightedIndex != NSNotFound) {
		[delegate buttonGridView:self buttonTappedAtIndex:highlightedIndex];
	}
	
	highlightedIndex = NSNotFound;
	[aScrollingView setNeedsDisplay];
}

- (CGRect)rectForButtonAtIndex:(NSInteger)index
{
	CGFloat horizontalMargin = (self.bounds.size.width - buttonSize.width * columnCount) / (columnCount + 1);
	CGFloat verticalMargin = (self.bounds.size.height - buttonSize.height * rowCount) / (rowCount + 1);
	
	NSInteger row = floor(index / columnCount);
	NSInteger column = index % columnCount;
	
	CGFloat x = (column + 1) * horizontalMargin + column * buttonSize.width;
	CGFloat y = (row + 1) * verticalMargin + row * buttonSize.height;
	
	return CGRectMake(x, y, buttonSize.width, buttonSize.height);
}


- (void)dealloc {
    [super dealloc];
}


@end
