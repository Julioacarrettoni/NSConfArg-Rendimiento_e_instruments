//
//  CTTouchInterceptingWindow.m
//  JACTouchIndicator
//
//  Created by Julio Carrettoni on 3/22/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import "CTTouchInterceptingWindow.h"
#import "JACTI_JRSwizzle.h"
#import <objc/runtime.h>

@implementation UIWindow (GK_CTTouchInterceptingWindow)

static BOOL swizzledMethod = NO;

+ (void) load {
    if (!swizzledMethod) {
        swizzledMethod = YES;
        [self JACTI_swizzleMethod:@selector(interceptedSendEvent:) withMethod:@selector(sendEvent:) error:nil];
    }
}

static char *eventInterceptorViewKey = "eventInterceptorView";
- (void) setEventInterceptorView:(UIView*) aView {
    objc_setAssociatedObject(self, &eventInterceptorViewKey, aView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (void) interceptedSendEvent:(UIEvent *)event {
    UIView* overlayView = (id)objc_getAssociatedObject(self, &eventInterceptorViewKey);
    NSArray* allTouches = [[event allTouches] allObjects];

    for (UITouch* touch in allTouches) {
        switch (touch.phase ) {
            case UITouchPhaseBegan:
                [overlayView touchesBegan:[NSSet setWithObject:touch] withEvent:event];
                break;
            case UITouchPhaseMoved:
                [overlayView touchesMoved:[NSSet setWithObject:touch] withEvent:event];
                break;
            case UITouchPhaseCancelled:
                [overlayView touchesCancelled:[NSSet setWithObject:touch] withEvent:event];
                break;
            case UITouchPhaseEnded:
                [overlayView touchesEnded:[NSSet setWithObject:touch] withEvent:event];
                break;
            default: break;
        }
    }
    [self interceptedSendEvent:event];//REMEMBER after the swizzle this call will be invoking the ORIGINAL method and NOT this one, so this is NOT a recursive call
}

@end
