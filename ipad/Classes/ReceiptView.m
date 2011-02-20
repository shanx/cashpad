//
//  ReceiptView.m
//  CashRegister-iPad
//
//  Created by Rits Plasman on 19-02-11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import "ReceiptView.h"
#import <QuartzCore/QuartzCore.h>
#import "ReceiptTotalView.h"
#import "ReceiptTitleView.h"

@implementation ReceiptView

@synthesize getReceiptButton;
@synthesize productTableView;
@synthesize receiptTotalView;
@synthesize receiptTitleView;
@synthesize payButton;
@synthesize onNameButton;

-(void)initCommon
{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
    // self.backgroundColor = [UIColor redColor];
    
}

-(void)awakeFromNib
{
    [self initCommon];
}

// must specify style at creation. -initWithFrame: calls this with UITableViewStylePlain
- (id)initWithFrame:(CGRect)frame; 
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self initCommon];
    }
    return self;
}


- (void)dealloc 
{
    [getReceiptButton release];
    [receiptTotalView release];
    [productTableView release];
    [receiptTitleView release];
    [payButton release];
    [onNameButton release];
    
    [super dealloc];
}


@end
