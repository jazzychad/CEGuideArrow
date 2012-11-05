//
//  CEGuideArrow.m
//
//  Created by Chad Etzel on 7/22/12.
//  Copyright (c) <2012> Chad Etzel
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.

#import "CEGuideArrow.h"

@implementation CEGuideArrow

@synthesize delegate = _delegate;
@synthesize displayed = _displayed;

static CEGuideArrow *_sharedGuideArrow;

+ (CEGuideArrow *)sharedGuideArrow
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedGuideArrow = [[CEGuideArrow alloc] init];
    });
    return _sharedGuideArrow;
}

- (id)init
{
    return [self initWithArrowImage:[self defaultArrowImage] anchorPoint:[self defaultAnchorPoint]];
}

- (id)initWithArrowImage:(UIImage *)arrowImage anchorPoint:(CGPoint)anchorPoint
{
    if (self = [super init]) {
        _arrowView = [[UIImageView alloc] initWithImage:arrowImage];
        _origSize = _arrowView.frame.size;
        _arrowView.layer.anchorPoint = anchorPoint;
    }
    return self;
}

- (void)dealloc
{
    [_arrowView release];
    
    [super dealloc];
}

- (UIImage *)defaultArrowImage
{
    // subclasses should return whatever image they want to use by default
    return [UIImage imageNamed:@"GuideArrow"];
}

- (CGPoint)defaultAnchorPoint
{
    //subclasses should return the anchor point to use for their default image
    return CGPointMake(1.0, 0.5);
}

- (void)removeCompleted
{
    [_arrowView removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(ceGuideArrow:didDisappearInWindow:atPoint:inView:length:)]) {
        [self.delegate ceGuideArrow:self didDisappearInWindow:_window atPoint:_point inView:_view length:_length];
    }
    
    _displayed = NO;
    [_arrowView.layer removeAnimationForKey:@"bounceAnimation"];
}

- (void)removeAnimated:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(ceGuideArrow:willDisappearInWindow:atPoint:inView:length:)]) {
        [self.delegate ceGuideArrow:self willDisappearInWindow:_window atPoint:_point inView:_view length:_length];
    }
    
    if (animated) {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowUserInteraction animations:^{
            
            [_arrowView setAlpha:0.0];
            
        } completion:^(BOOL finished) {
            
            [self removeCompleted];
            
        }];
        
    } else {
        
        [self removeCompleted];
        
    }
}

- (void)showInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view atAngle:(CGFloat)degrees length:(CGFloat)length
{
    
    if ([self.delegate respondsToSelector:@selector(ceGuideArrow:shouldShowArrowInWindow:atPoint:inView:length:)]) {
        if (![self.delegate ceGuideArrow:self shouldShowArrowInWindow:window atPoint:point inView:view length:length]) {
            return;
        }
    }
    
    _window = window;
    _view = view;
    _point = point;
    _length = length;
    
    if ([self.delegate respondsToSelector:@selector(ceGuideArrow:willAppearInWindow:atPoint:inView:length:)]) {
        [self.delegate ceGuideArrow:self willAppearInWindow:_window atPoint:_point inView:_view length:_length];
    }
    
    
    CGPoint windowPoint = [window convertPoint:point fromView:view];

    CGRect windowRect = [[view superview] convertRect:view.frame toView:window];

    windowPoint = CGPointMake(windowRect.origin.x + point.x, windowRect.origin.y + point.y);
    
    
    //// bounce animation

    [_arrowView.layer removeAnimationForKey:@"bounceAnimation"];
    
    CABasicAnimation *yAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    yAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    yAnimation.fromValue = [NSNumber numberWithFloat:0];
    yAnimation.toValue = [NSNumber numberWithFloat:0.0 - 10.0 * sin(M_PI/180.0 * degrees)];
    yAnimation.repeatCount = INT_MAX;
    yAnimation.autoreverses = YES;
    yAnimation.fillMode = kCAFillModeForwards;
    yAnimation.removedOnCompletion = NO;
    yAnimation.additive = YES;
    
    CABasicAnimation *xAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    xAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    xAnimation.fromValue = [NSNumber numberWithFloat:0];
    xAnimation.toValue = [NSNumber numberWithFloat:0.0 - 10.0 * cos(M_PI/180.0 * degrees)];
    xAnimation.repeatCount = INT_MAX;
    xAnimation.autoreverses = YES;
    xAnimation.fillMode = kCAFillModeForwards;
    xAnimation.removedOnCompletion = NO;
    xAnimation.additive = YES;
    
    CAAnimationGroup *bounceAnimation = [CAAnimationGroup animation];
    bounceAnimation.fillMode = kCAFillModeForwards;
    bounceAnimation.removedOnCompletion = NO;
    [bounceAnimation setAnimations:[NSArray arrayWithObjects:yAnimation, xAnimation, nil]];
    bounceAnimation.duration = 0.25;
    bounceAnimation.repeatCount = INT_MAX;
    bounceAnimation.autoreverses = YES;
    
    [_arrowView.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    
    if (!_displayed) {
        
        _arrowView.alpha = 0.0;
        [window addSubview:_arrowView];
        
    }
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction animations:^{
        
        [_arrowView setAlpha:1.0];
        
        CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(M_PI/180.0 * degrees);
        
        if (length == 0.0) {
            
            _arrowView.transform = rotateTransform;
            _arrowView.transform = CGAffineTransformScale(rotateTransform, 1.0, 1.0);
            
        } else {

            CGFloat ratio = length / _origSize.width;
            _arrowView.transform = CGAffineTransformScale(rotateTransform, ratio, ratio);
            
        }
        
        _arrowView.layer.position = windowPoint;
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(ceGuideArrow:didAppearInWindow:atPoint:inView:length:)]) {
            [self.delegate ceGuideArrow:self didAppearInWindow:_window atPoint:_point inView:_view length:_length];
        }
        
        _displayed = YES;
        
    }];
    
    
}

- (void)showInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view atAngle:(CGFloat)degrees
{
    [self showInWindow:window atPoint:point inView:view atAngle:degrees length:0.0];
}

- (void)showInWindow:(UIWindow *)window atPosition:(CEGuideArrowPositionType)position inView:(UIView *)view atAngle:(CGFloat)degrees length:(CGFloat)length
{
    CGPoint point;
    
    switch (position) {
        case CEGuideArrowPositionTypeTopLeft:
            point = CGPointMake(0.0, 0.0);
            break;
            
        case CEGuideArrowPositionTypeTopRight:
            point = CGPointMake(view.frame.size.width, 0.0);
            break;
            
        case CEGuideArrowPositionTypeBottomLeft:
            point = CGPointMake(0.0, view.frame.size.height);
            break;
            
        case CEGuideArrowPositionTypeBottomRight:
            point = CGPointMake(view.frame.size.width, view.frame.size.height);
            break;
            
        case CEGuideArrowPositionTypeTopCenter:
            point = CGPointMake(ceilf(view.frame.size.width / 2.0), 0.0);
            break;
            
        case CEGuideArrowPositionTypeBottomCenter:
            point = CGPointMake(ceilf(view.frame.size.width / 2.0), view.frame.size.height);
            break;
            
        case CEGuideArrowPositionTypeLeftCenter:
            point = CGPointMake(0.0, ceilf(view.frame.size.height / 2.0));
            break;
            
        case CEGuideArrowPositionTypeRightCenter:
            point = CGPointMake(view.frame.size.width, ceilf(view.frame.size.height / 2.0));
            break;
            
        case CEGuideArrowPositionTypeCenter:
            point = CGPointMake(ceilf(view.frame.size.width / 2.0), ceilf(view.frame.size.height / 2.0));
            break;
            
        default:
            point = CGPointMake(0.0, 0.0);
            break;
    }
    
    [self showInWindow:window atPoint:point inView:view atAngle:degrees length:length];
}

- (void)showInWindow:(UIWindow *)window atPosition:(CEGuideArrowPositionType)position inView:(UIView *)view atAngle:(CGFloat)degrees
{
    [self showInWindow:window atPosition:position inView:view atAngle:degrees length:0.0];
}

- (UIView *)arrowView
{
    return _arrowView;
}

@end
