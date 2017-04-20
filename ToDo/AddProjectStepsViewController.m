//
//  AddProjectStepsViewController.m
//  ToDo
//
//  Created by Matti Muehlemann on 12/24/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import "AddProjectStepsViewController.h"

@interface AddProjectStepsViewController ()

@end

@implementation AddProjectStepsViewController

/**
 * The method that runs when the view is loaded
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load Infromation
    info = [[InformationClass alloc] init];
    
    // Sets up the navigation items
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addItem)];
    UIBarButtonItem *leftItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    // Sets up the navBar
    UINavigationItem *item = [[UINavigationItem alloc] init];
    [item setTitle:@"Add A Project"];
    [item setRightBarButtonItem:rightItem];
    [item setLeftBarButtonItem:leftItem];
        
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[UIFont fontWithName:@"Avenir" size:21.0] forKey:NSFontAttributeName];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [navBar pushNavigationItem:item animated:NO];
    [navBar setTitleTextAttributes:attributes];
    [self.view addSubview:navBar];
    
    projectStepTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    [projectStepTF setPlaceholder:@"Project Step"];
    [projectStepTF setFont:[UIFont fontWithName:@"Avenir" size:20]];
    [projectStepTF becomeFirstResponder];
    [self.view addSubview:projectStepTF];
    
    projectDetailTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    [projectDetailTF setPlaceholder:@"Details"];
    [projectDetailTF setFont:[UIFont fontWithName:@"Avenir" size:20]];
    [self.view addSubview:projectDetailTF];
}

/**
 * Adds an item to the projectSteps array
 *
 */
- (void)addItem
{
    if ([projectStepTF.text isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"This request can not be preocessed without all of the data"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    else
    {
        NSMutableDictionary *dictMutableCopy = [[[info.information mutableCopy] objectAtIndex:[info.currentProject intValue]] mutableCopy];
        NSMutableArray      *arraMutableCopy = [[dictMutableCopy objectForKey:@"projectSteps"] mutableCopy];
        
        NSString *tempSting = [NSString stringWithFormat:@"%@^%@", projectStepTF.text, projectDetailTF.text];
        
        [arraMutableCopy addObject:tempSting];
        [dictMutableCopy setObject:arraMutableCopy forKey:@"projectSteps"];
        
        [info.information setObject:dictMutableCopy atIndexedSubscript:[info.currentProject intValue]];
        [info saveInformation];
        
        [projectStepTF resignFirstResponder];
        [projectDetailTF resignFirstResponder];
        
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}

/**
 * Dismisses the view
 *
 */
- (void)cancel
{
    [projectStepTF resignFirstResponder];
    [projectDetailTF resignFirstResponder];

    [self dismissViewControllerAnimated:YES completion:nil];
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
