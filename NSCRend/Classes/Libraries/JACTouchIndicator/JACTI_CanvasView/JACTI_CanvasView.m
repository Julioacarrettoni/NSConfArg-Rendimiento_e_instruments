//
//  JACTI_CanvasView.m
//  JACTouchIndicator
//
//  Created by Julio Carrettoni on 3/22/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import "JACTI_CanvasView.h"

#define MAX_NUMBER_OF_TOUCHES 22

@interface JACTI_CanvasView()

@end

@implementation JACTI_CanvasView {
    BOOL isActive[MAX_NUMBER_OF_TOUCHES];
    CGPoint touchPosition[MAX_NUMBER_OF_TOUCHES];
    
    //http://mobile.tutsplus.com/tutorials/iphone/ios-sdk_freehand-drawing/
}
- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}


-(void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void) initialize {
    for (int i = 0; i < MAX_NUMBER_OF_TOUCHES; i++) {
        isActive[i] = NO;
        self.thumbSize = 6.0;
    }
}

- (CGPoint) convertPointToLocalReferenceSystem:(CGPoint) point {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize localSize = self.frame.size;
    CGPoint offset;
    if (screenSize.width > screenSize.height) {
        localSize.height = (localSize.width/screenSize.width) * screenSize.height;
        offset.x = 0;
        offset.y = self.frame.size.height/2 - localSize.height/2;
    }
    else {
        localSize.width = (localSize.height/screenSize.height) * screenSize.width;
        offset.y = 0;
        offset.x = self.frame.size.width/2 - localSize.width/2;
    }
    
    point.x = offset.x + (point.x * localSize.width) / screenSize.width;
    point.y = offset.y + (point.y * localSize.height) / screenSize.height;
    return point;
}
- (void) touchEvent:(NSInteger) pointID beganFromPoint:(CGPoint) originalPoint{
    CGPoint point = [self convertPointToLocalReferenceSystem:originalPoint];
    isActive[pointID] = YES;
    touchPosition[pointID] = point;
    [self setNeedsDisplay];
}
- (void) touchEvent:(NSInteger) pointID movedToPoint:(CGPoint) originalPoint{
    CGPoint point = [self convertPointToLocalReferenceSystem:originalPoint];
    touchPosition[pointID] = point;
    [self setNeedsDisplay];
}

- (void) touchEvent:(NSInteger) pointID endedAtPoint:(CGPoint) originalPoint{
    isActive[pointID] = NO;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self.thumbColor setStroke];
    [self.thumbColor setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    CGFloat size = self.thumbSize;
    
    for (int i = 0; i < MAX_NUMBER_OF_TOUCHES; i++) {
        if (isActive[i]) {
            CGRect borderRect = CGRectMake(touchPosition[i].x -(size/2.0), touchPosition[i].y - (size/2.0), size, size);
            CGContextFillEllipseInRect (context, borderRect);
            CGContextFillPath(context);
        }
    }
    //http://www.infragistics.com/community/blogs/torrey-betts/archive/2013/05/28/quick-tip-dividing-a-cgrect-using-cgrectdivide-objective-c.aspx/
}


@end
