//
//  ProjectStepsViewController.h
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationClass.h"

@interface ProjectStepsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    InformationClass *info;
    UITableView *projectStepsTable;
    UIProgressView *projectProgress;
}

@end
