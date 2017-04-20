//
//  InformationClass.m
//  ToDo
//
//  Created by Matti Muehlemann on 12/23/14.
//  Copyright (c) 2014 Matti Muehlemann. All rights reserved.
//

#import "InformationClass.h"
#import "Constants.h"

@implementation InformationClass

@synthesize information;
@synthesize currentName;
@synthesize currentType;
@synthesize currentColor;
@synthesize currentProject;

/**
 * Initializes the class
 *
 */
- (id)init
{
    self = [super self];
    if (self)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([defaults objectForKey:@"information"] != nil)
        {
            information = [[defaults objectForKey:@"information"] mutableCopy];
            currentName = [defaults objectForKey:@"currentName"];
            currentType = [defaults objectForKey:@"currentType"];
            currentColor = [defaults objectForKey:@"currentColor"];
            currentProject = [defaults objectForKey:@"currentProject"];
        }
        else
        {
            information = [[NSMutableArray alloc] init];
            currentName = @"";
            currentType = @"";
            currentColor = @"";
            currentProject = @"0";

        }
        
    }
    
    return self;
}

/**
 * Returns a color depending on a string
 *
 * @param string The color string passed to the method
 */
- (UIColor *)colorFrom:(NSString *)string
{
    if ([[COLORSARRAY objectAtIndex:0] isEqualToString:string])
        return JUMBO;
    else if ([[COLORSARRAY objectAtIndex:1] isEqualToString:string])
        return BRIGHT_GRAY;
    else if ([[COLORSARRAY objectAtIndex:2] isEqualToString:string])
        return MORDANT_RED;
    else if ([[COLORSARRAY objectAtIndex:3] isEqualToString:string])
        return KU_CHRIMSON;
    else if ([[COLORSARRAY objectAtIndex:4] isEqualToString:string])
        return ORANGE;
    else if ([[COLORSARRAY objectAtIndex:5] isEqualToString:string])
        return DARK_ORANGE;
    else if ([[COLORSARRAY objectAtIndex:6] isEqualToString:string])
        return KURNIKOVA;
    else if ([[COLORSARRAY objectAtIndex:7] isEqualToString:string])
        return PASTEL_GREEN;
    else if ([[COLORSARRAY objectAtIndex:8] isEqualToString:string])
        return CARRIBEAN_GREEN;
    else if ([[COLORSARRAY objectAtIndex:9] isEqualToString:string])
        return JUNGLE_GREEN;
    else if ([[COLORSARRAY objectAtIndex:10] isEqualToString:string])
        return JELLEY_BEAN;
    else if ([[COLORSARRAY objectAtIndex:11] isEqualToString:string])
        return BAHAMA_BLUE;
    else if ([[COLORSARRAY objectAtIndex:12] isEqualToString:string])
        return RESOLUTION_BLUE;
    else if ([[COLORSARRAY objectAtIndex:13] isEqualToString:string])
        return PARIS_M;
    else if ([[COLORSARRAY objectAtIndex:14] isEqualToString:string])
        return EGGPLANT;
    else if ([[COLORSARRAY objectAtIndex:15] isEqualToString:string])
        return WINDSOR;
    else if ([[COLORSARRAY objectAtIndex:16] isEqualToString:string])
        return DARK_ORCHID;
    else if ([[COLORSARRAY objectAtIndex:17] isEqualToString:string])
        return HOT_MAGENTA;
    
    return [UIColor lightGrayColor];
}

/**
 * Saves the information to the user defaults
 *
 */
- (void)saveInformation
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:information forKey:@"information"];
    [defaults setObject:currentName forKey:@"currentName"];
    [defaults setObject:currentType forKey:@"currentType"];
    [defaults setObject:currentColor forKey:@"currentColor"];
    [defaults setObject:currentProject forKey:@"currentProject"];
}

@end
