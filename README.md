RPSliderController
=============
-------------

RPSliderController is a UIViewController container that allows one UIViewController to become slidable. You can check [here](http://www.youtube.com/watch?v=3Hso1sRNR2U&feature=youtu.be) how it works 

------------
Requirements
============

RPSliderController currently works on iOS 6 version and is compatible with ARC. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* QuartzCore.framework

------------------------------------
Adding RPSliderController to your project
====================================

Source files
------------

The simplest way to add the RPSliderController to your project is to directly add the `RPSliderViewController.h` and `RPSliderViewController.m` source files to your project.

1. Download the [latest code version](https://github.com/RuiAAPeres/SliderController) or add the repository as a git submodule to your git-tracked project. 
2. Open your project in Xcode, than drag and drop `RPSliderViewController.h` and `RPSliderViewController.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project. 
3. Include RPSliderViewController wherever you need it with `#import "RPSliderViewController.h"`.

-----
Usage
=====

The only thing you need to do to work with RPSliderController is to sub-class it:

```objective-c
#import "RPSliderViewController.h"
@interface MyViewController : RPSliderViewController
```

In order to init it you can do the following (don't forget that MyViewController is a sub-class of RPSliderViewController):

```objective-c
UIViewController *detailViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    
MyViewController *myViewController = [[MyViewController alloc] initWithNibName:nil bundle:nil slideController:detailViewController];
```
For the moment the only thing you can do with it is to change the UIViewController that is acting as the slider. From the sub-class you can do:

```objective-c
UIViewController *newDetailViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
[self replaceSliderWithViewController:newDetailViewController];
```

-------
Known Issues
=======

- If the Slider's UIViewController contains a UIView that responds to gestures (UIScrollView or UITableView) in some cases, there might be issues with the final position of the Slider
- It's expected that the user does a complete gesture in order for the Slider to pass from the left to the right side (and vice versa). In YouTube iOS's Application for instance, the user doesn't need to do that, only a small gesture is enough for the Slider to travel from left to right (and vice versa)

-------
RoadMap
=======

- Fix the Known Issues in an elegant way. :)
- Add more control over the Slider
=======

License
=======

This code is distributed under the terms and conditions of the MIT license. 

----------
Change-log
==========

**Version 1.2* @ 13.4.12

- Fixed a bug that would allow several UIViewController's to be considered as the Slider's ViewController (we should allow only one)

**Version 1.1* @ 12.4.12

- Updated the README.md file

**Version 1.0* @ 12.4.12

- First version