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


-(void)initCommon
{
    CGRect ownBounds = self.bounds;
    
    receiptTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0,
                                                                  ownBounds.size.width - 20.0,
                                                                  ownBounds.size.height - 10.0)];
    
    receiptTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    receiptTitleLabel.text = @"Kassabon";
    receiptTitleLabel.textColor = [UIColor grayColor];
    
    [self addSubview:receiptTitleLabel];
    
    UIImageView* lineImageView = [[UIImageView alloc] 
                                  initWithImage:[UIImage imageNamed:@"dashed-line.png"]];
    
    CGRect lineImageViewFrame = lineImageView.frame;
    lineImageViewFrame.origin.x = (ownBounds.size.width - lineImageViewFrame.size.width)/2;
    lineImageViewFrame.origin.y = 5.0 + receiptTitleLabel.frame.size.height + 1.0;
    lineImageView.frame = lineImageViewFrame;

    [self addSubview:lineImageView];
    [lineImageView release];
}

-(void)awakeFromNib
{
    [self initCommon];
}

-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self initCommon];
    }
    
    return self;
}

-(void)dealloc
{
    [receiptTitleLabel release];
    [super dealloc];
}


@end
