//
//  main.m
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 02/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "wrikeModels.h"

int main(int argc, const char * argv[]) {
    TaskCollection* coll = [[TaskCollection alloc] init];
    [coll fetch];
    NSLog(@"HELLO");
    return 0;
}
