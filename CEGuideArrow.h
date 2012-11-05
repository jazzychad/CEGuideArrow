//
//  CEGuideArrow.h
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

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    CEGuideArrowPositionTypeTopLeft,
    CEGuideArrowPositionTypeTopRight,
    CEGuideArrowPositionTypeBottomLeft,
    CEGuideArrowPositionTypeBottomRight,
    CEGuideArrowPositionTypeTopCenter,
    CEGuideArrowPositionTypeBottomCenter,
    CEGuideArrowPositionTypeLeftCenter,
    CEGuideArrowPositionTypeRightCenter,
    CEGuideArrowPositionTypeCenter,
    
    
} CEGuideArrowPositionType;

@protocol CEGuideArrowDelegate;

@interface CEGuideArrow : NSObject {
    UIImageView *_arrowView;
    CGSize _origSize;
    
    UIWindow *_window;
    UIView *_view;
    CGPoint _point;
    CGFloat _length;
}

@property (nonatomic, assign) id<CEGuideArrowDelegate> delegate;
@property (nonatomic, assign, getter = isDisplayed) BOOL displayed;

+ (CEGuideArrow *)sharedGuideArrow;

- (id)initWithArrowImage:(UIImage *)arrowImage anchorPoint:(CGPoint)anchorPoint;

- (void)showInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view atAngle:(CGFloat)degrees length:(CGFloat)length;

- (void)showInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view atAngle:(CGFloat)degrees;

- (void)showInWindow:(UIWindow *)window atPosition:(CEGuideArrowPositionType)position inView:(UIView *)view atAngle:(CGFloat)degrees length:(CGFloat)length;

- (void)showInWindow:(UIWindow *)window atPosition:(CEGuideArrowPositionType)position inView:(UIView *)view atAngle:(CGFloat)degrees;

- (void)removeAnimated:(BOOL)animated;

- (UIImage *)defaultArrowImage;

- (CGPoint)defaultAnchorPoint;

- (UIView *)arrowView;

@end

@protocol CEGuideArrowDelegate <NSObject>

@optional

- (BOOL)ceGuideArrow:(CEGuideArrow *)guideArrow shouldShowArrowInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length;

- (void)ceGuideArrow:(CEGuideArrow *)guideArrow willAppearInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length;

- (void)ceGuideArrow:(CEGuideArrow *)guideArrow didAppearInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length;

- (void)ceGuideArrow:(CEGuideArrow *)guideArrow willDisappearInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length;

- (void)ceGuideArrow:(CEGuideArrow *)guideArrow didDisappearInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length;

@end



