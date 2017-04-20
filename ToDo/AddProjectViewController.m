//
//  AddProjectViewController.m
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import "AddProjectViewController.h"
#import "Constants.h"
#import "ProjectViewController.h"

@interface AddProjectViewController ()

@end

@implementation AddProjectViewController

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
    
    projectNameTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    [projectNameTF setPlaceholder:@"Project Name"];
    [projectNameTF setFont:[UIFont fontWithName:@"Avenir" size:20]];
    [projectNameTF becomeFirstResponder];
    [self.view addSubview:projectNameTF];
    
    projectTypeTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    [projectTypeTF setPlaceholder:@"Project Type"];
    [projectTypeTF setFont:[UIFont fontWithName:@"Avenir" size:20]];
    [self.view addSubview:projectTypeTF];
    
    for (int i = 0; i < 6; i++)
    {
        UIButton *aColor = [[UIButton alloc] initWithFrame:CGRectMake(20 + ([UIScreen mainScreen].bounds.size.width / 6.5) * (i -  0), 160, 36, 36)];
        [aColor addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
        [aColor setTitle:@"" forState:UIControlStateNormal];
        [aColor.layer setCornerRadius:2];
        [aColor setAlpha:0.5];
        [aColor setTag:i + 1];
        [aColor setBackgroundColor:[info colorFrom:[COLORSARRAY objectAtIndex:i]]];
        [self.view addSubview:aColor];
    }
    
    for (int i = 6; i < 12; i++)
    {
        UIButton *aColor = [[UIButton alloc] initWithFrame:CGRectMake(20 + ([UIScreen mainScreen].bounds.size.width / 6.5) * (i -  6), 210, 36, 36)];
        [aColor addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
        [aColor setTitle:@"" forState:UIControlStateNormal];
        [aColor.layer setCornerRadius:2];
        [aColor setAlpha:0.5];
        [aColor setTag:i + 1];
        [aColor setBackgroundColor:[info colorFrom:[COLORSARRAY objectAtIndex:i]]];
        [self.view addSubview:aColor];
    }
    
    if ([UIScreen mainScreen].bounds.size.height != 480)
    {
        for (int i = 12; i < 18; i++)
        {
            UIButton *aColor = [[UIButton alloc] initWithFrame:CGRectMake(20 + ([UIScreen mainScreen].bounds.size.width / 6.5) * (i - 12), 260, 36, 36)];
            [aColor addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
            [aColor setTitle:@"" forState:UIControlStateNormal];
            [aColor.layer setCornerRadius:2];
            [aColor setAlpha:0.5];
            [aColor setTag:i + 1];
            [aColor setBackgroundColor:[info colorFrom:[COLORSARRAY objectAtIndex:i]]];
            [self.view addSubview:aColor];
        }
    }
}

/**
 * Handels the selecting of color
 *
 */
- (void)colorSelected:(id)sender
{
    [projectNameTF resignFirstResponder];
    [projectTypeTF resignFirstResponder];
    
    // Clear all buttons
    for (UIButton *aButton in [self.view subviews])
    {
        if (aButton.tag != 0)
        {
            aButton.alpha = 0.5;
        }
    }
    
    // Cast the sender to another button
    UIButton *temp = (UIButton *)sender;
    temp.alpha = 1;
    
    selectedColor = [COLORSARRAY objectAtIndex:temp.tag - 1];
}

/**
 * Adds an item to the projects array
 *
 */
- (void)addItem
{
    if ([projectNameTF.text isEqualToString:@""] || [projectTypeTF.text isEqualToString:@""] || selectedColor == nil)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"This request can not be preocessed without all of the data"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    else
    {
        NSMutableDictionary *project = [[NSMutableDictionary alloc] init];
        [project setObject:[NSString stringWithFormat:@"%@^%@^%@", projectNameTF.text, projectTypeTF.text, selectedColor] forKey:@"projectInfo"];
        [project setObject:[[NSMutableArray alloc] initWithArray:@[]] forKey:@"projectSteps"];
        
        [info.information addObject:project];
        [info saveInformation];
        
        [projectNameTF resignFirstResponder];
        [projectTypeTF resignFirstResponder];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 * Dismisses the view
 *
 */
- (void)cancel
{
    [projectNameTF resignFirstResponder];
    [projectTypeTF resignFirstResponder];
    
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
