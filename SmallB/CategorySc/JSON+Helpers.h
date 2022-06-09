//
//  JSON+Helpers.h
//  mystar
//
//  Created by mos on 13-2-22.
//  Copyright (c) 2013年 medev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Utility)

- (id)objectForKeyNotNull:(id)key;

- (id)objectForKeyNotBackNull:(id)key;


- (NSDictionary *)deleteNull;

@end
