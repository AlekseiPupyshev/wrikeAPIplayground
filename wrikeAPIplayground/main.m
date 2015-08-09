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

// https://www.wrike.com/oauth2/authorize?client_id=XcanYk6P&response_type=code

int main(int argc, const char * argv[]) {
    NSString* clientID = @"XcanYk6P";
    NSString* clientSecret = @"QBDzdgWrMVktBi5QrNqeIyEoRKqJCLzzJ9IoAwu8E6Vm0CuPWiGjAGREbWgr69lC";
    NSString* code = @"NhEKWIXvnDiPKEnnsygtJtVRJBKtJElJX7PW86OeOpPae5E2Vj6qb11RVbInGukRb-N";
    
    OAuth2Credentials *OAuth = [[OAuth2Credentials alloc] init];
    [OAuth initWithClientID: clientID withClientSecret: clientSecret withAccessCode: code];
    [OAuth getAccessToken];
    
    
    return 0;
}
