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

- (void)drawRect:(CGRect)rect
{
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
