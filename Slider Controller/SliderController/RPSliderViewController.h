//
//  RPSliderViewController.h
//  Slider Controller
//
//  Created by Rui Peres on 12/4/12.
//  Copyright (c) 2012 Rui Peres. All rights reserved.
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2012 Rui Peres
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 Used to pass the gestures and touches that happen on the Slider Controller
 */
@protocol RPCustomGestureRecognizerDelegate <UIGestureRecognizerDelegate>

@required

- (void) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer movedWithTouches:(NSSet*)touches andEvent:(UIEvent *)event;

- (void) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer endWithTouches:(NSSet*)touches andEvent:(UIEvent *)event;

@optional

- (void) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer beganWithTouches:(NSSet*)touches andEvent:(UIEvent *)event;

@end

/**
 UIViewController that will be used as the one that is behind the
 one that slides.
 This UIViewController should be sub-classed in order to be used
 */
@interface RPSliderViewController : UIViewController <RPCustomGestureRecognizerDelegate>

/**
 Basic init of the UIViewController with an extra parameter that will be
 the slide controller. We will keep a strong reference to it.
 @param nibNameOrNil
 @param nibBundleOrNil
 @param slideViewController UIViewController that will be used to slide
 */
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil slideController:(UIViewController *)slideViewController;

/**
 It will replace the current slider with another UIViewController
 @param newSliderViewController the new slider
 @return void
 */
- (void)replaceSliderWithViewController:(UIViewController *)newSliderViewController;

@end