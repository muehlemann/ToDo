//
//  CustomCell.h
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, retain) UILabel *projectTitle;
@property (nonatomic, retain) UILabel *projectSubtitle;
@property (nonatomic, retain) UILabel *projectProgress;
@property (nonatomic, retain) UIView *colorIdenitifier;

@end
