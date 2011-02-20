//
//  ReceiptTableViewCell.m
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 . All rights reserved.
//

#import "ProductTableViewCell.h"
#import "Product.h"
#import <QuartzCore/QuartzCore.h>

@implementation ProductTableViewCell
@synthesize nameLabel;
@synthesize priceLabel;
@synthesize amountLabel;
@synthesize cellView;

-(void)initCommon
{
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderColor = [UIColor redColor].CGColor;
    self.contentView.layer.borderWidth = 1.0;
    
    self.cellView.layer.masksToBounds = YES;
    self.cellView.layer.borderColor = [UIColor blueColor].CGColor;
    self.cellView.layer.borderWidth = 1.0;
    
}

-(void)awakeFromNib
{
    [self initCommon];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) 
    {
        [[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:self options:nil];
        CGRect contentViewBounds = self.contentView.bounds;
        cellView.bounds = contentViewBounds;
        self.contentView.clipsToBounds = YES;
        [self.contentView addSubview:cellView];
        
        [self initCommon];
	}
	
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc 
{
    [cellView release];
    [amountLabel release];
    [nameLabel release];
    [priceLabel release];
    
    [super dealloc];
}


@end
