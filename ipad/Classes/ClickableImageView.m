//
//  ClickableImageView.m
//  Hyves
//
//  Created by Teun van Run on 8/22/08.
//  Copyright 2008 Service2Media B.V. All rights reserved. Redistribution is strictly prohibited.
//

#import "ClickableImageView.h"

#define TRANSPARENTTAG 1

@implementation ClickableImageView

@synthesize delegate;
@synthesize propagateTouchEvents;
@synthesize longTapTimer;
@synthesize longTapDuration;

- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
    {
        // Initialization code
        propagateTouchEvents = YES;
    }
    return self;
}


- (void)dealloc 
{
    [longTapTimer invalidate];
    [longTapTimer release];
    
    [super dealloc];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* hitView = propagateTouchEvents ? [super hitTest:point withEvent:event] : nil;
    
    if (hitView == nil && CGRectContainsPoint(self.bounds, point))
    {
        return self;
    }
    else
    {
        // Either hitView is not nil (only happens when propagating touch events)
        // or hitView IS nil, and the touch was done outside of own bounds.
        return hitView;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if(CGRectContainsPoint(self.bounds, point)){
        return YES;
    }else{
        return NO;
    }
}

-(void)touchDurationExpired:(NSTimer*)aTimer
{
    if (delegate != nil && [(NSObject*)delegate respondsToSelector:@selector(imageClicked:atPoint:duration:)])
    {
        [delegate imageClicked:self atPoint:touchesBeganLocation duration:longTapDuration];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (   delegate != nil 
        && [touches count] == 1 
        && [(NSObject*)delegate respondsToSelector:@selector(imageClicked:atPoint:duration:)])
    {
        UITouch* touch = [touches anyObject];
        touchesBeganTimeStamp = [event timestamp];
        touchesBeganLocation = [touch locationInView:self];
        
        if (longTapDuration > 0)
        {
            [longTapTimer invalidate];
            
            self.longTapTimer = [NSTimer scheduledTimerWithTimeInterval:longTapDuration 
                                                                 target:self 
                                                               selector:@selector(touchDurationExpired:) 
                                                               userInfo:nil 
                                                                repeats:NO];
        }
    }
    
    if (propagateTouchEvents)
    {
        [super touchesBegan:touches withEvent:event];
    }
    
}
 


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (delegate != nil)
    {
        if ([touches count] == 1 && [(NSObject*)delegate respondsToSelector:@selector(imageClicked:atPoint:duration:)])
        {
            [longTapTimer invalidate];
            UITouch* touch = [touches anyObject];
            CGPoint location = [touch locationInView:self];
            NSTimeInterval touchTimeStamp = [event timestamp];
            NSTimeInterval duration = touchTimeStamp - touchesBeganTimeStamp;
            
            // Call the delegate either in case of no specified tap duration
            // or when the touch ended before the timer expired.
            if (longTapDuration == 0)
            {
                [delegate imageClicked:self atPoint:location duration:duration];
            }
        }

        if (delegate != nil && [(NSObject*)delegate respondsToSelector:@selector(imageClicked:)])
        {
            [delegate imageClicked:self];
        }
    }
    
    if (propagateTouchEvents)
    {
        [super touchesEnded:touches withEvent:event];
    }
}

-(void)setSelected:(BOOL)selected
{
    if(selected)
    {
        //add a subview with a tag
        UIView *transparentView=[[UIView alloc]initWithFrame:[self bounds]];
        transparentView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        transparentView.tag=TRANSPARENTTAG;
        [self addSubview:transparentView];
        [transparentView release];
    }
    else
    {
        UIView *transparentView=[self viewWithTag:TRANSPARENTTAG];
        [transparentView removeFromSuperview];
    }
}


@end
