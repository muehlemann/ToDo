//
//  ProjectViewController.m
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import "ProjectViewController.h"
#import "Constants.h"
#import "CustomCell.h"

@interface ProjectViewController ()

@end

@implementation ProjectViewController

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
    [self setTitle:@"ToDo's"];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    // TableView
    projectsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [projectsTable setDataSource:self];
    [projectsTable setDelegate:self];
    [projectsTable setRowHeight:60];
    [self.view addSubview:projectsTable];
    
    // Add Button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProject)];
}

/**
 * Method that runs wehn the view is awakend
 *
 * @param animated The state of animation
 */
- (void)viewDidAppear:(BOOL)animated
{
    info = [[InformationClass alloc] init];
    
    [self setTitle:@"ToDo's"];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [projectsTable reloadData];
}

- (void)addProject
{
    [self performSegueWithIdentifier:@"projectsToAddProject" sender:self];
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
    return [info.information count];
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
    
    float total = (float)[[[info.information objectAtIndex:indexPath.row] objectForKey:@"projectSteps"] count];
    float compleated = 0;
    
    for (int i = 0; i < total; i++)
        if ([[[[info.information objectAtIndex:indexPath.row] objectForKey:@"projectSteps"] objectAtIndex:i] rangeOfString:@"Completed"].location != NSNotFound)
            compleated++;
    
    float progress = (compleated / total) * 100;
    if ([[NSString stringWithFormat:@"%0.0f%%", progress] isEqualToString:@"nan%"])
        cell.projectProgress.text = @"";
    else
        cell.projectProgress.text = [NSString stringWithFormat:@"%0.0f%%", progress];
    
    NSArray *tempArray = [[[info.information objectAtIndex:indexPath.row] objectForKey:@"projectInfo"] componentsSeparatedByString:@"^"];
    [cell.projectTitle setText:[tempArray objectAtIndex:0]];
    [cell.projectSubtitle setText:[tempArray objectAtIndex:1]];
    [cell.colorIdenitifier setBackgroundColor:[info colorFrom:[tempArray objectAtIndex:2]]];
    

    
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
    [self setTitle:@""];
    
    for (int i = 0; i < [COLORSARRAY count]; i++)
        if ([[[info.information objectAtIndex:indexPath.row] objectForKey:@"projectInfo"] rangeOfString:[COLORSARRAY objectAtIndex:i]].location != NSNotFound)
            [info setCurrentColor:[COLORSARRAY objectAtIndex:i]];
    
    NSArray *tempArray = [[[info.information objectAtIndex:indexPath.row] objectForKey:@"projectInfo"] componentsSeparatedByString:@"^"];
    [info setCurrentName:[tempArray objectAtIndex:0]];
    [info setCurrentProject:[NSString stringWithFormat:@"%ldl", (long)indexPath.row]];
    [info saveInformation];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"projectsToProjectSteps" sender:self];
}

/**
 * This method sets up the edit actions for the tableview
 *
 * @param tableView The instance of the tableview
 * @param indexPath The indexpath that was selected
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *doneButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                      title:@"Done"
                                                                    handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        [info.information removeObjectAtIndex:indexPath.row];
                                        [info saveInformation];
                                        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
                                    }];
    [doneButton setBackgroundColor:[UIColor lightGrayColor]];
    
    UITableViewRowAction *emailButton = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                          title:@"Email"
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                        {
                                            NSArray *titleString = [[[info.information objectAtIndex:indexPath.row] objectForKey:@"projectInfo"] componentsSeparatedByString:@"^"];
                                            NSArray *items = [[info.information objectAtIndex:indexPath.row] objectForKey:@"projectSteps"];
                                        
                                            [self emailProjectWithTitle:titleString andItems:items];
                                        }];
    [emailButton setBackgroundColor:[UIColor colorWithRed:0.2 green:0.42 blue:0.66 alpha:1]];
    
    return [NSArray arrayWithObjects:doneButton, emailButton, nil];
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
 * Presents the email view controller.
 *
 */
- (void)emailProjectWithTitle:(NSArray *)titleString andItems:(NSArray *)items
{
    NSString *itemsCompleated = @"";
    NSString *itemsInProgress = @"";
    
    for (int i = 0; i < [items count]; i++)
    {
        if ([[items objectAtIndex:i] rangeOfString:@"Completed"].location != NSNotFound)
        {
            itemsCompleated = [NSString stringWithFormat:@"%@\n- %@", itemsCompleated, [[[items objectAtIndex:i] componentsSeparatedByString:@"^"] objectAtIndex:0]];
        }
        else
        {
            itemsInProgress = [NSString stringWithFormat:@"%@\n- %@", itemsInProgress, [[[items objectAtIndex:i] componentsSeparatedByString:@"^"] objectAtIndex:0]];
        }
    }
    
    
    NSString *emailString = [NSString stringWithFormat:@"\nProject Name: %@\nIn Progress:%@\n\nCompleted:%@", [titleString objectAtIndex:0], itemsInProgress, itemsCompleated];
    
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = self;
    [mailController setToRecipients:nil];
    [mailController setSubject:@""];
    [mailController setMessageBody:emailString isHTML:NO];

    [self presentViewController:mailController animated:YES completion:NULL];
}

/**
 * Handles all of the possible things that could happen when sending an eamil.
 *
 * @param controller The current mail controller present.
 * @param result     The ending result after the email has been executed.
 * @param error      The error that occurs when somthing is wrong.
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
        
    [self dismissViewControllerAnimated:YES completion:NULL];
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
