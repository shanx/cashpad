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
	NSInteger index = [scrollingViews indexOfObject:aScrollingView];
	
	DLog(@"drawing scrollview %d", index);
	
	UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
	
	CGFloat horizontalMargin = (self.bounds.size.width - buttonImage.size.width * columnCount) / (columnCount + 1);
	CGFloat verticalMargin = (self.bounds.size.height - buttonImage.size.height * rowCount) / (rowCount + 1);
	
	DLog(@"horizontalMargin:%f verticalMargin:%f", horizontalMargin, verticalMargin);
	
	NSInteger buttonsPerPage = rowCount * columnCount;
	
	for (NSInteger i = 0; i < buttonsPerPage; i++) {
		DLog(@"drawing button %d", i);
		if (i + index * buttonsPerPage >= [titles count]) {
			DLog(@"skipping button %d", i);
			break;
		}
		
		NSString *title = [titles objectAtIndex:i];
		
		CGSize titleSize = [title sizeWithFont:titleFont];
		
		NSInteger row = floor(i / columnCount);
		NSInteger column = i % columnCount;
		
		CGFloat x = (column + 1) * horizontalMargin + (column + 0.5) * buttonImage.size.width - titleSize.width / 2.0;
		CGFloat y = (row + 1) * verticalMargin + (row + 0.5) * buttonImage.size.height - titleSize.height / 2.0;
		
		[[UIColor blackColor] set];
		[title drawAtPoint:CGPointMake(x, y) withFont:titleFont];		
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
