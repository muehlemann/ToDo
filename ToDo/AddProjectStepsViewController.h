//
//  AddProjectStepsViewController.h
//  ToDo
//
//  Created by Matti Muehlemann on 12/24/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationClass.h"

@interface AddProjectStepsViewController : UIViewController
{
    InformationClass *info;
    
    UITextField *projectStepTF;
    UITextField *projectDetailTF;
}

@end
