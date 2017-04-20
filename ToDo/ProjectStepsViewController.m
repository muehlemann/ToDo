//
//  ProjectStepsViewController.m
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import "ProjectStepsViewController.h"
#import "Constants.h"
#import "CustomCell.h"

@interface ProjectStepsViewController ()

@end

@implementation ProjectStepsViewController

/**
 * The method that runs when the view is loaded
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load Infromation
    info = [[InformationClass alloc] init];
    
    // Navigation Bar
    [self setTitle:[info currentName]];
    [self.navigationController.navigationBar setTintColor:[info colorFrom:[info currentColor]]];
    
    // Progress View
    projectProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 2)];
    [projectProgress setTintColor:[info colorFrom:[info currentColor]]];
    [projectProgress setProgress:1 animated:NO];
    [self.view addSubview:projectProgress];
    
    // TableView
    projectStepsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 70)];
    [projectStepsTable setDataSource:self];
    [projectStepsTable setDelegate:self];
    [projectStepsTable setRowHeight:60];
    [self.view addSubview:projectStepsTable];
    
    // Add Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProjectStep)];
}

/**
 * Method that runs wehn the view is awakend
 *
 * @param animated The state of animation
 */
- (void)viewDidAppear:(BOOL)animated
{
    info = [[InformationClass alloc] init];
    [self.navigationController.navigationBar setTintColor:[info colorFrom:[info currentColor]]];
    [projectStepsTable reloadData];
}

/**
 * Goes to the add project step screen
 *
 */
- (void)addProjectStep
{
    [self performSegueWithIdentifier:@"projectStepsToAddProjectSteps" sender:nil];
}

/**
 * Method that runs to determine the number of sections in a tableview
 *
 * @param tableView The instance of the tableview
 * @param indexPath The sections of the tableview
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 * Method that runs to determine the number of rows in sections in a tableview
 *
 * @param tableView The instance of the tableview
 * @param section   The sections of the tableview
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[info.information objectAtIndex:[info.currentProject intValue]] objectForKey:@"projectSteps"] count];
}

/**
 * Method that determines the hight of the tableview
 *
 * @param tableView The instance of the tableview
 * @param indexPath The indexpath that was selected
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

/**
 * Method that populates the tableview
 *
 * @param tableView The instance of the tableview
 * @param indexPath The indexpath that was selected
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSArray *tempArray = [[info.information objectAtIndex:[info.currentProject intValue]] objectForKey:@"projectSteps"];
    
    [cell.projectTitle setText:[[[tempArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"^"] objectAtIndex:0]];
    [cell.projectSubtitle setText:[[[tempArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"^"] objectAtIndex:1]];
    
    if ([[[[[info.information objectAtIndex:[info.currentProject intValue]] objectForKey:@"projectSteps"] objectAtIndex:indexPath.row] componentsSeparatedByString:@"^"] count] >= 3)
    {
        cell.userInteractionEnabled = NO;
        [cell.projectTitle setTextColor:[UIColor lightGrayColor]];
        [cell.projectSubtitle setTextColor:[UIColor lightGrayColor]];
    }
    
    return cell;
}

/**
 * Method that runs when a cell is selected
 *
 * @param tableView The instance of the tableview
 * @param indexPath The indexpath that was selected
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CustomCell *cell = (CustomCell *)[tableView cellForRowAtIndexPath:indexPath];
        
    [[[UIAlertView alloc] initWithTitle:cell.projectTitle.text
                                message:cell.projectSubtitle.text
                               delegate:self cancelButtonTitle:@"Done"
                      otherButtonTitles:nil] show];
}

/**
 * This method sets up the edit actions for the tableview
 *
 * @param tableView The instance of the tableview
 * @param indexPath The indexpath that was selected
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Add a table row action button
    UITableViewRowAction *doneButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                          title:@"Completed"
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            NSMutableDictionary *dictMutableCopy = [[[info.information mutableCopy] objectAtIndex:[info.currentProject intValue]] mutableCopy];
                                            NSMutableArray      *arraMutableCopy = [[dictMutableCopy objectForKey:@"projectSteps"] mutableCopy];

                                            [arraMutableCopy setObject:[NSString stringWithFormat:@"%@^Completed", [arraMutableCopy objectAtIndex:indexPath.row]] atIndexedSubscript:indexPath.row];
                                            
                                            [dictMutableCopy setObject:arraMutableCopy forKey:@"projectSteps"];

                                            [info.information setObject:dictMutableCopy atIndexedSubscript:[info.currentProject intValue]];
                                            [info saveInformation];
                                            
                                            [tableView reloadData];
                                        }];
    [doneButton setBackgroundColor:[UIColor lightGrayColor]];
    
    return [NSArray arrayWithObjects:doneButton, nil];
}

/**
 * This method allowes the user to edit the tableview
 *
 * @param tableView The instance of the tableview
 * @param editingStyle The editing style of the tableview
 * @param indexPath The indexpath that was selected
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView reloadData];
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
