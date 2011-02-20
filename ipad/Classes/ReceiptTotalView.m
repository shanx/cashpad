//
//  ProductTableViewFooter.m
//  CashRegister-iPad
//
//  Created by Sergey Novitsky on 2/19/11.
//  Copyright 2011 FlockOfFlies. All rights reserved.
//

#import "ReceiptTotalView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ReceiptTotalView
@synthesize paymentTextLabel;
@synthesize paymentTotalLabel;


-(void)initCommon
{
    // self.layer.masksToBounds = YES;
    // self.layer.borderColor = [UIColor redColor].CGColor;
    // self.layer.borderWidth = 3.0;
    //self.backgroundColor = [UIColor redColor];
    
    CGRect ownBounds = self.bounds;
    CGRect paymentTextLabelFrame = 
    CGRectMake(10.0, 10.0, ownBounds.size.width/2.0, 30.0);
    
    UIView* lineView = [[UIView alloc] initWithFrame:
                        CGRectMake(10.0, 1.0, ownBounds.size.width - 20, 1.0)];
    
    lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView];
    [lineView release];
    
    paymentTextLabel = [[UILabel alloc] initWithFrame:paymentTextLabelFrame];
    
    //paymentTextLabel.layer.masksToBounds = YES;
    //paymentTextLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //paymentTextLabel.layer.borderWidth = 1.0;
    //paymentTextLabel.backgroundColor = [UIColor redColor];
    paymentTextLabel.font = [UIFont italicSystemFontOfSize:20];
    
    paymentTextLabel.text = @"Te betalen";
    paymentTextLabel.textColor = [UIColor grayColor];
    
    [self addSubview:paymentTextLabel];
    
    CGRect paymentTotalLabelFrame =
    CGRectMake(ownBounds.size.width/3.0, paymentTextLabelFrame.size.height + 10, 
               ownBounds.size.width * 2.0/3.0 - 10.0, 
               ownBounds.size.height - 20.0 - paymentTextLabelFrame.size.height);
    
    paymentTotalLabel = [[UILabel alloc] initWithFrame:paymentTotalLabelFrame];
    
    //paymentTotalLabel.layer.masksToBounds = YES;
    //paymentTotalLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //paymentTotalLabel.layer.borderWidth = 1.0;
    //paymentTotalLabel.backgroundColor = [UIColor redColor];
    paymentTotalLabel.font = [UIFont italicSystemFontOfSize:30];
    
    // paymentTotalLabel.text = [NSString stringWithFormat:@"%C %@", 0x20ac, @"44,00"];
    paymentTotalLabel.textAlignment = UITextAlignmentCenter;
    paymentTotalLabel.textColor = [UIColor grayColor];
    
    [self addSubview:paymentTotalLabel];
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
    [paymentTextLabel release];
    [paymentTotalLabel release];
    
    [super dealloc];
}


@end
