//
//  RPSliderViewController.m
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

#import "RPSliderViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

// The amount of space that will be visible when sliderViewController is "slidded off"
#define MAX_VISIBLE_SIDE 250.0f
// The distance bounced when the slide reaches one of the edges (left or right)
#define BOUNCE_DISTANCE 10.0f
// The middle of the screen. Basically where the animation is decided. (to go left or right)
#define ANIMATION_LIMIT 160.0f
// A distance to get the UIView out of the screen
#define BYE_BYE_X 500.0f
// The sensibility of the movement when we make a gesture
#define MOVEMENT_SENSIBILITY 20.0f
// The maximun X location when we have the Slidder Filling the screen and we want to slide it
#define MINIMUM_X 60.0f

/**
 Subclass of the Gesture Recognizer so we are able to get the touches out
 of the Gesture.
 */
@interface RPCustomGestureRecognizer : UIPanGestureRecognizer

@end

@implementation RPCustomGestureRecognizer

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(gestureRecognizer:beganWithTouches:andEvent:)])
    {
        [(id)self.delegate gestureRecognizer:self beganWithTouches:touches andEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(gestureRecognizer:movedWithTouches:andEvent:)])
    {
        [(id)self.delegate gestureRecognizer:self movedWithTouches:touches andEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(gestureRecognizer:endWithTouches:andEvent:)])
    {
        [(id)self.delegate gestureRecognizer:self endWithTouches:touches andEvent:event];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(gestureRecognizer:endWithTouches:andEvent:)])
    {
        [(id)self.delegate gestureRecognizer:self endWithTouches:touches andEvent:event];
    }
}

@end

@interface RPSliderViewController ()

// Strong reference to the slideController
@property(nonatomic,strong)UIViewController *slideController;

/**
 It will set the gestures for the slider and its initial
 position
 @return void
 */
- (void)basicInitForSlidderViewController;

/**
 The animation performed when we release the slider UIViewController
 @return void
 */
- (void)flexingAnimation;

/**
 Informs the delegate that the current slider has been removed
 @return void
 */
- (void)currentSliderHasBeenRemoved;

/**
 Informs the delegate that the slidding animating is finished
 and the new Slider is in position
 @return void
 */
- (void)newSliderHasBeenAdded;

@end

@implementation RPSliderViewController

@synthesize slideController = _slideController;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil slideController:(UIViewController *)slideViewController
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        _slideController = slideViewController;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create a scope to  better organize the code visually (odd habits)
	{
        // Inform self that we just added the sliderController
        [self addChildViewController:_slideController];
        [_slideController didMoveToParentViewController:self];
        
        // Add the _slider's view to as self's subview
        [[self view]addSubview:[_slideController view]];
        
        // Set the initial position of the SliderController
        [[_slideController view] setFrame:CGRectMake(MAX_VISIBLE_SIDE, _slideController.view.frame.origin.y, _slideController.view.frame.size.width, _slideController.view.frame.size.height)];
        
        [self basicInitForSlidderViewController];
    }
}

#pragma mark - Slidding Animation Callouts

- (void)currentSliderHasBeenRemoved
{
    // To be sub-classed
}

- (void)newSliderHasBeenAdded
{
    // To be sub-classed
}

#pragma mark - Private Methods (UI)

- (void)flexingAnimation
{
    double initialPositionX = 0.0f;
    double finalPositionX = 0.0f;
    
    if (_slideController.view.frame.origin.x > ANIMATION_LIMIT)
    {
        double bounceValue = _slideController.view.frame.origin.x < MAX_VISIBLE_SIDE?BOUNCE_DISTANCE:-BOUNCE_DISTANCE;
        initialPositionX = MAX_VISIBLE_SIDE + bounceValue;
        finalPositionX = MAX_VISIBLE_SIDE;
    }
    else
    {
        initialPositionX = _slideController.view.frame.origin.x == 0.0f?0.0f:-BOUNCE_DISTANCE;
        finalPositionX = 0.0f;
    }
    
    // Start the animation to the maximun point
    [UIView animateWithDuration:0.3 animations:^{
        [_slideController.view setFrame:CGRectMake(initialPositionX, 0.0f, _slideController.view.frame.size.width, _slideController.view.frame.size.height)];
    } completion:^(BOOL finished) {
        // Get back to the original position
        [UIView animateWithDuration:0.3 animations:^{
            [_slideController.view setFrame:CGRectMake(finalPositionX, 0.0f, _slideController.view.frame.size.width, _slideController.view.frame.size.height)];
        }];
    }];
}


- (void)basicInitForSlidderViewController
{
    // Create the gesture
    RPCustomGestureRecognizer *gesture = [[RPCustomGestureRecognizer alloc] init];
    
    // Set the delegate as self
    [gesture setDelegate:self];
    
    [gesture setMaximumNumberOfTouches:2];
    
    // Add the Gesture to the _slideController
    [[_slideController view] addGestureRecognizer:gesture];
    
    // Add the shadow effect
    _slideController.view.layer.shadowOffset = CGSizeMake(-15, 0);
    _slideController.view.layer.shadowRadius = 5;
    _slideController.view.layer.shadowOpacity = 0.7;
    
    _slideController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:_slideController.view.bounds].CGPath;

}


#pragma mark - Transition Method

- (void)replaceSliderWithViewController:(UIViewController *)newSliderViewController
{
    // check if we are replacing a view
    if(isReplacingSlider)
    {
        // We will stop here if we are replacing a view
        return;
    }
    // Flag that we are we going to start to the replace the Slider
    isReplacingSlider = YES;
    
    // Add the new slider as a child
    [self addChildViewController:newSliderViewController];
    [self.view addSubview:[newSliderViewController view]];
    
    // Flag the current slideController to be removed
    [_slideController willMoveToParentViewController:nil];
    
    [newSliderViewController.view setFrame:CGRectMake(BYE_BYE_X, 0.0f, newSliderViewController.view.frame.size.width, newSliderViewController.view.frame.size.height)];
    
    [UIView animateWithDuration:0.3 animations:^{
        // Make a little animation of the slider going to the left
        [_slideController.view setFrame:CGRectMake(MAX_VISIBLE_SIDE - BOUNCE_DISTANCE, 0.0f, _slideController.view.frame.size.width, _slideController.view.frame.size.height)];
    } completion:^(BOOL finished) {
        // Make the current slider get out of the view
        [UIView animateWithDuration:0.4 animations:^{
            [_slideController.view setFrame:CGRectMake(BYE_BYE_X, 0.0f, _slideController.view.frame.size.width, _slideController.view.frame.size.height)];
            
        } completion:^(BOOL finished) {
            
            // Finally remove it
            [_slideController removeFromParentViewController];
            
            // Inform self that the current Slider has been removed
            [self currentSliderHasBeenRemoved];
            
            // Set the new _slider
            _slideController = newSliderViewController;
            
            // Add the gestures and the shadow
            [self basicInitForSlidderViewController];
            
            // Create the animation of the new Slider coming
            [UIView animateWithDuration:0.3 animations:^{
                // Animate it to just a bit after it's initial position
                [newSliderViewController.view setFrame:CGRectMake(MAX_VISIBLE_SIDE - BOUNCE_DISTANCE, 0.0f, newSliderViewController.view.frame.size.width, newSliderViewController.view.frame.size.height)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    // Put in on the original position
                    [newSliderViewController.view setFrame:CGRectMake(MAX_VISIBLE_SIDE, 0.0f, newSliderViewController.view.frame.size.width, newSliderViewController.view.frame.size.height)];
                } completion:^(BOOL finished) {
                    // Notify self that the newSlider is in position
                    [newSliderViewController didMoveToParentViewController:self];
                    
                    // Flag that we are not replacing the slider
                    isReplacingSlider = NO;
                    
                    // Inform self that the new Slider has been added
                    [self newSliderHasBeenAdded];

                }];
            }];
        }];
    }];
}

#pragma mark - RPCustomGestureRecognizerDelegate Implementation

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // We return YES. This is for cases when the Slider has UIView's like UITableView and UIScrollView where different
    // Gestures should be recognized
    return YES;
}


- (void)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer beganWithTouches:(NSSet*)touches andEvent:(UIEvent *)event
{
    if (gestureRecognizer.state == UIGestureRecognizerStatePossible)
    {
        // Based on the touches we can calculate what's the next position
        UITouch *aTouch = [touches anyObject];
        CGPoint gestureLocation = [aTouch locationInView:_slideController.view];

        if (gestureLocation.x > MINIMUM_X)
        {
            [gestureRecognizer ignoreTouch:aTouch forEvent:event];
        }
    }
}


- (void) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer movedWithTouches:(NSSet*)touches andEvent:(UIEvent *)event
{
    if (gestureRecognizer.state == UIGestureRecognizerStatePossible)
    {
        // Based on the touches we can calculate what's the next position
        UITouch *aTouch = [touches anyObject];
        CGPoint gestureLocation = [aTouch locationInView:self.view];
        
        // The previous position
        CGPoint previousLocation = [aTouch previousLocationInView:self.view];
        
        // Next possible Frame and Location
        CGRect possibleNewRect = CGRectOffset(_slideController.view.frame, gestureLocation.x-previousLocation.x, gestureLocation.y- previousLocation.y);
        
        CGPoint possibleNewLocation = possibleNewRect.origin;
        
        double movementSensibility = previousLocation.x - gestureLocation.x;

        // First check if the gesture was fast. If it was we will just scroll to the side the gesture was
        if(ABS(movementSensibility) >= MOVEMENT_SENSIBILITY)
        {
            // Ok it was fast enough, check if it was to the right or to the left
            double finalPosition = movementSensibility<0.0f?MAX_VISIBLE_SIDE + BOUNCE_DISTANCE:0.0f - BOUNCE_DISTANCE;
            [gestureRecognizer setEnabled:NO];
            
            // Animate to it
            [UIView animateWithDuration:.3f animations:^{
                [_slideController.view setFrame:CGRectMake(finalPosition, 0.0f, _slideController.view.frame.size.width, _slideController.view.frame.size.height)];
            } completion:^(BOOL finished)
             {
                 // Cancel the remaining gestures
                 [gestureRecognizer setEnabled:YES];
                 [self flexingAnimation];
            }];
        }
        
        // Just guarantee that the new location will not be less than zero
        if (possibleNewLocation.x > 0 && ABS(movementSensibility) < MOVEMENT_SENSIBILITY)
        {
            CGRect sliderFrame = _slideController.view.frame;
            
            _slideController.view.frame = CGRectMake(possibleNewLocation.x, sliderFrame.origin.y, sliderFrame.size.width, sliderFrame.size.height);
        }
    }
}

- (void) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer endWithTouches:(NSSet*)touches andEvent:(UIEvent *)event
{    
    if (![gestureRecognizer isEnabled])
    {
        // If the gesture is disabled we won't do anything
        return;
    }

    [self flexingAnimation];
}

@end



