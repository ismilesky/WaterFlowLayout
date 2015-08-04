//
//  Model.m
//  WaterFlowLayout
//
//  Created by 小爪乎黑 on 15/7/29.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "Model.h"

@implementation Model

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"width"]) {
        self.width = [value floatValue];
    }
    
    if ([key isEqualToString:@"height"]) {
        self.height = [value floatValue];
    }

}


@end
