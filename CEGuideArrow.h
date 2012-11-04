//
//  CEGuideArrow.h
//  Pixit
//
//  Created by Charles Etzel on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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



