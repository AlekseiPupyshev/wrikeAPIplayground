//
//  main.m
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 02/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "wrikeSDK.m"

int main(int argc, const char * argv[]) {
    TaskCollection* coll;
    [coll fetch];
    return 0;
}
