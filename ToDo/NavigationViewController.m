//
//  NavigationViewController.m
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

/**
 * The method that runs when the view is loaded
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[UIFont fontWithName:@"Avenir" size:21.0] forKey:NSFontAttributeName];
    
    [self.navigationBar setTitleTextAttributes:attributes];
}

/**
 * The method that runs when the view controller recives a memory warning
 *
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
