//
//  ReceiptTableViewCell.m
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "Product.h"

@implementation ProductTableViewCell

@synthesize product;

- (id)initWithProduct:(Product *)aProduct reuseIdentifier:(NSString *)identifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	
	if (self) {
		product = [aProduct retain];
	}
	
	return self;
}

- (void)setProduct:(Product *)aProduct
{
	if (product == aProduct) {
		return;
	}
	
	[aProduct retain];
	[product release];
	product = aProduct;
	
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
	NSString *productName = product.name;
	UIFont *nameFont = [UIFont boldSystemFontOfSize:16];
	CGSize nameSize = [productName sizeWithFont:nameFont];
	CGFloat x = 20.0;
	CGFloat y = (self.bounds.size.height - nameSize.height) / 2.0;
	CGPoint namePoint = CGPointMake(x, y);
	
	[[UIColor blackColor] set];
	[productName drawAtPoint:namePoint withFont:nameFont];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
