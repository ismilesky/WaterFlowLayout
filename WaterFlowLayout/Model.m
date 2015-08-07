//
//  Model.m
//  WaterFlowLayout
//

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
