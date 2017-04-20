//
//  CustomCell.m
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize projectTitle;
@synthesize projectSubtitle;
@synthesize projectProgress;
@synthesize colorIdenitifier;

/**
 * The initializer function of a custom tableview cell
 *
 * @param style           The stile of the tableview cell
 * @param reuseIdentifier The reuse identifier of the tableview cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {        
        self.projectTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width - 35, 30)];
        [self.projectTitle setFont:[UIFont fontWithName:@"Avenir-Light" size:22]];
        [self addSubview:self.projectTitle];
        
        self.projectSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, [UIScreen mainScreen].bounds.size.width - 35, 22)];
        [self.projectSubtitle setFont:[UIFont fontWithName:@"Avenir-Light" size:14]];
        [self.projectSubtitle setTextColor:[UIColor lightGrayColor]];
        [self addSubview:self.projectSubtitle];
        
        self.colorIdenitifier = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 15, 0, 15, 60)];
        [self addSubview:self.colorIdenitifier];
        
        self.projectProgress = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 22, 0, 30, 60)];
        [self.projectProgress setFont:[UIFont fontWithName:@"Avenir-Light" size:12]];
        [self.projectProgress setTextColor:[UIColor whiteColor]];
        [self.projectProgress setTextAlignment:NSTextAlignmentCenter];
        [self.projectProgress setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        [self addSubview:self.projectProgress];

        [self setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 15)];
    }
    
    return self;
}

/**
 * The method that runs when a cell is selected
 *
 * @param selected The state of selection
 * @param animated The state of animation
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
