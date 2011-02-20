//
//  ReceiptTitleView.m
//  CashRegister-iPad
//
//  Created by Sergey Novitsky on 2/20/11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import "ReceiptTitleView.h"


@implementation ReceiptTitleView
@synthesize receiptTitleLabel;

-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        CGRect ownBounds = self.bounds;
        
        receiptTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0,
                             ownBounds.size.width - 20.0,
                             ownBounds.size.height - 10.0)];
        
        receiptTitleLabel.font = [UIFont boldSystemFontOfSize:20];
        receiptTitleLabel.text = @"Kassabon";
        receiptTitleLabel.textColor = [UIColor grayColor];
        
        [self addSubview:receiptTitleLabel];
        UIView* lineView = [[UIView alloc] initWithFrame:
                            CGRectMake(0.0, 5.0 + receiptTitleLabel.frame.size.height + 1.0, 
                                       ownBounds.size.width, 1)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        [lineView release];
    }
    
    return self;
}

-(void)dealloc
{
    [receiptTitleLabel release];
    [super dealloc];
}


@end
