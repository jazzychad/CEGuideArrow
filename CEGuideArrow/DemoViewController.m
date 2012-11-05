//
//  DemoViewController.m
//  CEGuideArrow
//
//  Created by Chad Etzel on 11/4/12.
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

#import "DemoViewController.h"
#import "AppDelegate.h"


#define APP_WINDOW  (((AppDelegate *)[[UIApplication sharedApplication] delegate]).window)

@interface DemoViewController ()

@end

@implementation DemoViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = @"CEGuideArrow";
        [[CEGuideArrow sharedGuideArrow] setDelegate:self];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    
}

- (void)loadView
{
    [super loadView];
    
    _buttonOne = [self generateButtonWithTitle:@"Button One"];
    _buttonOne.frame = CGRectMake(15.0, 15.0, 100.0, 40.0);
    [self.view addSubview:_buttonOne];
    
    _buttonTwo = [self generateButtonWithTitle:@"Button Two"];
    _buttonTwo.frame = CGRectMake(self.view.frame.size.width - 100.0 - 15.0, 15.0, 100.0, 40.0);
    [self.view addSubview:_buttonTwo];
    
    _buttonThree = [self generateButtonWithTitle:@"Button Three"];
    _buttonThree.frame = CGRectMake(15.0, self.view.frame.size.height - 40.0 - 15.0, 100.0, 40.0);
    _buttonThree.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_buttonThree];
    
    _buttonFour = [self generateButtonWithTitle:@"Button Four"];
    _buttonFour.frame = CGRectMake(self.view.frame.size.width - 100.0 - 15.0, self.view.frame.size.height - 40.0 - 15.0, 100.0, 40.0);
    _buttonFour.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_buttonFour];
    
    _buttonFive = [self generateButtonWithTitle:@"Button Five"];
    _buttonFive.frame = CGRectMake(self.view.frame.size.width / 2.0 - 100.0 / 2.0, self.view.frame.size.height / 2.0 - 40.0 / 2.0, 100.0, 40.0);
    _buttonFive.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_buttonFive];
}

- (UIButton *)generateButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - other

- (void)buttonTapped:(id)sender
{
    if (sender == _buttonOne) {
        
        [[CEGuideArrow sharedGuideArrow] showInWindow:APP_WINDOW atPosition:CEGuideArrowPositionTypeBottomCenter inView:_buttonOne atAngle:-90.0 length:80.0];
        
    } else if (sender == _buttonTwo) {
        
        [[CEGuideArrow sharedGuideArrow] showInWindow:APP_WINDOW atPosition:CEGuideArrowPositionTypeBottomLeft inView:_buttonTwo atAngle:-45.0 length:100.0];
        
    } else if (sender == _buttonThree) {
        
        [[CEGuideArrow sharedGuideArrow] showInWindow:APP_WINDOW atPosition:CEGuideArrowPositionTypeRightCenter inView:_buttonThree atAngle:180.0 length:30.0];
        
    } else if (sender == _buttonFour) {
        
        [[CEGuideArrow sharedGuideArrow] showInWindow:APP_WINDOW atPosition:CEGuideArrowPositionTypeCenter inView:_buttonFour atAngle:100.0 length:0];
        
    } else if (sender == _buttonFive) {
        
        if ([CEGuideArrow sharedGuideArrow].isDisplayed) {
            
            [[CEGuideArrow sharedGuideArrow] removeAnimated:YES];
            
        } else {
        
            [[CEGuideArrow sharedGuideArrow] showInWindow:APP_WINDOW atPoint:CGPointMake(15.0, 0.0) inView:_buttonFive atAngle:90.0 length:120.0];
        }
    }
}

#pragma mark - CEGuideArrowDelegate methods

- (BOOL)ceGuideArrow:(CEGuideArrow *)guideArrow shouldShowArrowInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length
{
    return YES;
}

- (void)ceGuideArrow:(CEGuideArrow *)guideArrow willAppearInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length
{
    NSLog(@"Guide Arrow willAppear:");
}

- (void)ceGuideArrow:(CEGuideArrow *)guideArrow didAppearInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length
{
    NSLog(@"Guide Arrow didAppear:");
}

- (void)ceGuideArrow:(CEGuideArrow *)guideArrow willDisappearInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length
{
    NSLog(@"Guide Arrow willDisappear:");
}

- (void)ceGuideArrow:(CEGuideArrow *)guideArrow didDisappearInWindow:(UIWindow *)window atPoint:(CGPoint)point inView:(UIView *)view length:(CGFloat)length
{
    NSLog(@"Guide Arrow didDisapear:");
}

@end
