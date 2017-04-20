//
//  InformationClass.h
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InformationClass : NSObject

@property (nonatomic, retain) NSMutableArray *information;
@property (nonatomic, retain) NSString *currentName;
@property (nonatomic, retain) NSString *currentType;
@property (nonatomic, retain) NSString *currentColor;
@property (nonatomic, retain) NSString *currentProject;

- (id)init;
- (UIColor *)colorFrom:(NSString *)string;
- (void)saveInformation;

@end
