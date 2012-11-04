//
//  DemoViewController.h
//  CEGuideArrow
//
//  Created by Chad Etzel on 11/4/12.
//  Copyright (c) 2012 Chad Etzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEGuideArrow.h"

@interface DemoViewController : UIViewController <CEGuideArrowDelegate> {
    UIButton *_buttonOne;
    UIButton *_buttonTwo;
    UIButton *_buttonThree;
    UIButton *_buttonFour;
    UIButton *_buttonFive;
}

@end
