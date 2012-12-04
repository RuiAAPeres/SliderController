RPSlideController
=============
-------------

RPSlideController is a UIViewController container that allows the View to add a Detail UIViewController that slides.

------------
Requirements
============

RPSlideController currently works on iO S6 version and is compatible with ARC. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* QuartzCore.framework


------------------------------------
Adding RPSlideController to your project
====================================

Source files
------------

The simplest way to add the RPSlideController to your project is to directly add the `RPSliderViewController.h` and `RPSliderViewController.m` source files to your project.

1. Download the [latest code version](https://github.com/RuiAAPeres/SliderController) or add the repository as a git submodule to your git-tracked project. 
2. Open your project in Xcode, than drag and drop `RPSliderViewController.h` and `RPSliderViewController.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project. 
3. Include RPSliderViewController wherever you need it with `#import "RPSliderViewController.h"`.

-----
Usage
=====

The only thing you need to do work with RPSlideController is to sub-class it:

```objective-c
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
License
=======

This code is distributed under the terms and conditions of the MIT license. 

----------
Change-log
==========

**Version 1.1* @ 12.4.12

- Updated the README.md file

**Version 1.0* @ 12.4.12

- First version