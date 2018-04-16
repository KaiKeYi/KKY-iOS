//
//  NSArray+Log.m
//  KKY
//
//  Created by Jason on 2018/4/16.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString*)descriptionWithLocale:(id)locale {
    
    NSMutableString*str = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop) {
        
        [str appendFormat:@"\t%@,\n", obj];
        
    }];
    
    [str appendString:@")"];
    
    return str;
}

@end

@implementation NSDictionary (Log)

- (NSString*)descriptionWithLocale:(id)locale {
    
    NSMutableString *str = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop) {
        
        [str appendFormat:@"\t%@ = %@;\n", key, obj];
        
    }];
    
    [str appendString:@"}\n"];
    
    return str;
}

@end
