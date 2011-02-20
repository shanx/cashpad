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
@synthesize highlightedButtonImage;
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
	self.backgroundColor = [UIColor redColor];
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
	for (ScrollingView *scrollingView in scrollingViews) {
		[scrollingView removeFromSuperview];
	}
	[scrollingViews removeAllObjects];
	
	NSInteger buttonCount = [titles count];
	NSInteger buttonsPerPage = rowCount * columnCount;
	NSInteger numberOfPages = ceil((float) buttonCount / buttonsPerPage);
	
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
	
	self.contentSize = CGSizeMake(numberOfPages * self.bounds.size.width, self.bounds.size.height);
}

- (void)scrollingView:(ScrollingView *)aScrollingView drawRect:(CGRect)rect
{
	[[UIColor redColor] set];
	UIRectFill(rect);
	
	NSInteger pageIndex = [scrollingViews indexOfObject:aScrollingView];

	
	UIFont *titleFont = [UIFont boldSystemFontOfSize:22];
	
	CGFloat horizontalMargin = (self.bounds.size.width - buttonSize.width * columnCount) / (columnCount + 1);
	CGFloat verticalMargin = (self.bounds.size.height - buttonSize.height * rowCount) / (rowCount + 1);
	
	NSInteger buttonsPerPage = rowCount * columnCount;
	
	for (NSInteger i = 0; i < buttonsPerPage; i++) {
		NSInteger index = i + pageIndex * buttonsPerPage;
		if (index >= [titles count]) {
			break;
		}
		
		NSString *title = [titles objectAtIndex:index];
		
		CGSize titleSize = [title sizeWithFont:titleFont];
		
		NSInteger row = floor(i / columnCount);
		NSInteger column = i % columnCount;
		
		CGFloat x = (column + 1) * horizontalMargin + column * buttonSize.width;
		CGFloat y = (row + 1) * verticalMargin + row * buttonSize.height;
		
		CGFloat titleX = x + 0.5 * buttonSize.width - titleSize.width / 2.0;
		CGFloat titleY = y + 0.5 * buttonSize.height - titleSize.height / 2.0 + 20.0;
		
		
		if (index == highlightedIndex) {
			[highlightedButtonImage drawAtPoint:CGPointMake(x, y)];
		} else {
			[buttonImage drawAtPoint:CGPointMake(x, y)];
		}
		
		[[UIColor blackColor] set];
		[title drawAtPoint:CGPointMake(titleX, titleY) withFont:titleFont];		
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
