//
//  AddProjectViewController.h
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationClass.h"

@interface AddProjectViewController : UIViewController <UITextFieldDelegate>
{
    InformationClass *info;
    NSString *selectedColor;
    
    UITextField *projectNameTF;
    UITextField *projectTypeTF;
}

@end
