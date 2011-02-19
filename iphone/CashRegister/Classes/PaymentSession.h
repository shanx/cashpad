//
//  NearbyMatch.h
//  MinesweeperFlags
//
//  Created by Rits Plasman on 23-01-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol PaymentSessionDelegate;

@class PaymentRequest;

@interface PaymentSession : NSObject <GKSessionDelegate>
{
	GKSession *session;
}

@property (nonatomic, assign) id <PaymentSessionDelegate> delegate;
@property (nonatomic, retain, readonly) PaymentRequest *receivedRequest;
@property (nonatomic, retain, readonly) PaymentRequest *sentRequest;

- (id)initWithGKSession:(GKSession *)aSession;
- (void)sendPaymentRequest:(PaymentRequest *)request;
- (void)acceptPaymentRequest:(PaymentRequest *)request;
- (void)denyPaymentRequest:(PaymentRequest *)request;

@end
