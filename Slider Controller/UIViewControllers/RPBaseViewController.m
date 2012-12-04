//
//  RPBaseViewController.m
//  Slider Controller
//
//  Created by Rui Peres on 12/4/12.
//  Copyright (c) 2012 Rui Peres. All rights reserved.
//

#import "RPBaseViewController.h"
#import "RPDetailViewController.h"

#define CELL_IDENTIFIER @"cellIdentifier"

@interface RPBaseViewController ()

@end

@implementation RPBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource Implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%d",[indexPath row] + 1]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RPDetailViewController *detailViewController = [[RPDetailViewController alloc] initWithNibName:nil bundle:nil];
    
    // Method to replace the Detail UIViewController
    [self replaceSliderWithViewController:detailViewController];
}

@end
