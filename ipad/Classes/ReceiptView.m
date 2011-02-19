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

@implementation ReceiptView

@synthesize productTableView;
@synthesize receiptTotalView;

#define TOTAL_VIEW_HEIGHT 100.0

-(void)initCommon
{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.backgroundColor = [UIColor lightGrayColor];
    
    CGRect ownBounds = self.bounds;
    CGRect totalViewFrame = CGRectMake(0.0, ownBounds.size.height - TOTAL_VIEW_HEIGHT, ownBounds.size.width, TOTAL_VIEW_HEIGHT);
    
    receiptTotalView = [[UIView alloc] initWithFrame:totalViewFrame];
    receiptTotalView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    receiptTotalView.layer.masksToBounds = YES;
    receiptTotalView.layer.borderColor = [UIColor blueColor].CGColor;
    receiptTotalView.layer.borderWidth = 1.0;
    receiptTotalView.backgroundColor = [UIColor greenColor];
    
    
    [self addSubview:receiptTotalView];
    
    productTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, ownBounds.size.width, 
                         ownBounds.size.height - TOTAL_VIEW_HEIGHT) style:UITableViewStylePlain];
    
    productTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    productTableView.layer.masksToBounds = YES;
    productTableView.layer.borderColor = [UIColor redColor].CGColor;
    productTableView.layer.borderWidth = 1.0;
    
    [self addSubview:productTableView];
}

-(void)awakeFromNib
{
    [self initCommon];
}

// must specify style at creation. -initWithFrame: calls this with UITableViewStylePlain
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style; 
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
    [receiptTotalView release];
    [productTableView release];
    
    [super dealloc];
}


@end
