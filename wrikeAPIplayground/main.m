//
//  main.m
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 02/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
