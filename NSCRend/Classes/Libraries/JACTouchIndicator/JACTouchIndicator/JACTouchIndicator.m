//
//  JACTouchIndicator.m
//  JACTouchIndicator
//
//  Created by Julio Carrettoni on 3/22/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import "JACTouchIndicator.h"
#import "JACTI_CanvasView.h"
#import "CTTouchInterceptingWindow.h"

#define MAX_NUMBER_OF_TOUCHES 22

@interface JACTouchIndicator()

@property (nonatomic, retain) JACTI_CanvasView* canvasView;

@end

@implementation JACTouchIndicator {
    UITouch* trackedTouches[MAX_NUMBER_OF_TOUCHES];
}

+ (instancetype) showInWindow:(UIWindow*) window {
    static JACTouchIndicator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [window setEventInterceptorView:sharedInstance];
    });
    return [sharedInstance show];
}

- (instancetype) show {
    self.windowLevel = UIWindowLevelAlert;
    self.hidden = NO;
    self.frame = [UIScreen mainScreen].bounds;
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        self.frame = [UIScreen mainScreen].bounds;
        self.rootViewController = [UIViewController new];
        self.rootViewController.view.alpha = 0.0;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.5;
        [self createSubviews];
    }
    return self;
}

- (void) createSubviews {
    self.canvasView = [[JACTI_CanvasView alloc] initWithFrame:self.bounds];
    self.canvasView.autoresizesSubviews = YES;
    self.canvasView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.canvasView.backgroundColor = [UIColor clearColor];
    self.canvasView.clearsContextBeforeDrawing = NO;
    self.canvasView.opaque = NO;
    self.canvasView.clipsToBounds = NO;
    self.canvasView.contentMode = UIViewContentModeScaleToFill;
    self.canvasView.multipleTouchEnabled = NO;
    self.canvasView.userInteractionEnabled = YES;
    self.canvasView.thumbSize = 45.0;
    self.canvasView.thumbColor = [UIColor whiteColor];
    
    [self addSubview:self.canvasView];
}

#pragma mark - Touch IDs
- (NSInteger) touchIDForTouch:(UITouch*) touch {
    for (int i = 0; i < MAX_NUMBER_OF_TOUCHES; i++){
        if (trackedTouches[i] == touch) {
            return i;
        }
    }
    return [self trackTouch:touch];
}

- (NSInteger) trackTouch:(UITouch*) touch {
    for (int i = 0; i < MAX_NUMBER_OF_TOUCHES; i++){
        if (trackedTouches[i] == nil) {
            trackedTouches[i] = touch;
            return i;
        }
    }
    return NSNotFound;
}

- (void) untrackTouchWithTouchID:(NSInteger) touchID {
    trackedTouches[touchID] = nil;
}

#pragma mark gesture forwardings
- (CGPoint) pointFromTouch:(UITouch*) touch {
    return [touch locationInView:self];
}

- (CGAffineTransform)currentTransformOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            return CGAffineTransformMakeRotation(M_PI_2);
            
        case UIInterfaceOrientationLandscapeRight:
            return CGAffineTransformMakeRotation(-M_PI_2);
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGAffineTransformMakeRotation(M_PI);
            
        case UIInterfaceOrientationPortrait:
        default:
            return CGAffineTransformIdentity;
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    for (UITouch* touch in touches) {
        NSInteger touchID = [self touchIDForTouch:touch];
        if (touchID != NSNotFound) {
            CGPoint point = [self pointFromTouch:touch];
            [self.canvasView touchEvent:touchID beganFromPoint:point];
        }
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    for (UITouch* touch in touches) {
        NSInteger touchID = [self touchIDForTouch:touch];
        if (touchID != NSNotFound) {
            CGPoint point = [self pointFromTouch:touch];
            [self.canvasView touchEvent:touchID movedToPoint:point];
        }
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self handleTouch:touches EndedEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self handleTouch:touches EndedEvent:event];
}

- (void) handleTouch:(NSSet *)touches EndedEvent:(UIEvent *)event{
    for (UITouch* touch in touches) {
        NSInteger touchID = [self touchIDForTouch:touch];
        if (touchID != NSNotFound) {
            CGPoint point = [self pointFromTouch:touch];
            [self.canvasView touchEvent:touchID endedAtPoint:point];
            [self untrackTouchWithTouchID:touchID];
        }
    }
}

@end