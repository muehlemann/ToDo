//
//  ProjectViewController.h
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "InformationClass.h"

@interface ProjectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
{
    InformationClass *info;
    UITableView *projectsTable;
}

@end

