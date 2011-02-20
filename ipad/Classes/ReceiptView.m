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

@synthesize productTableView;
@synthesize receiptTotalView;
@synthesize receiptTitleView;

#define TOTAL_VIEW_HEIGHT 100.0
#define TITLE_VIEW_HEIGHT 50.0

-(void)initCommon
{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
    // self.backgroundColor = [UIColor redColor];
    
    CGRect ownBounds = self.bounds;
    
    CGRect titleViewFrame = CGRectMake(10.0, 10.0, 
                                       ownBounds.size.width - 20.0, TITLE_VIEW_HEIGHT);
    
    
    receiptTitleView = [[ReceiptTitleView alloc] initWithFrame:titleViewFrame];

    //receiptTitleView.layer.masksToBounds = YES;
    //receiptTitleView.layer.borderColor = [UIColor grayColor].CGColor;
    //receiptTitleView.layer.borderWidth = 1.0;
    
    
    [self addSubview:receiptTitleView];
    
    CGRect totalViewFrame = 
        CGRectMake(0.0, ownBounds.size.height - TOTAL_VIEW_HEIGHT, 
                                       ownBounds.size.width, TOTAL_VIEW_HEIGHT);
    
    receiptTotalView = [[ReceiptTotalView alloc] initWithFrame:totalViewFrame];
    receiptTotalView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:receiptTotalView];
    
    productTableView = [[UITableView alloc] initWithFrame:
                        CGRectMake(10.0, 10.0 + TITLE_VIEW_HEIGHT, ownBounds.size.width - 20.0, 
                         ownBounds.size.height - TOTAL_VIEW_HEIGHT - TITLE_VIEW_HEIGHT - 10.0) 
                                                    style:UITableViewStylePlain];
    
    productTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    //productTableView.layer.masksToBounds = YES;
    //productTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //productTableView.layer.borderWidth = 1.0;
    
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
    [receiptTitleView release];
    
    [super dealloc];
}


@end
