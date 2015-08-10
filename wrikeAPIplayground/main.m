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
// CoW3Wqx0rWPRLxa90MJGnmr0ZPtk8FoRaz9qD1GQsarA1Zz979MXUKaslqqxpfSM-N-N

int main(int argc, const char * argv[]) {
    NSString* clientID = @"XcanYk6P";
    NSString* clientSecret = @"QBDzdgWrMVktBi5QrNqeIyEoRKqJCLzzJ9IoAwu8E6Vm0CuPWiGjAGREbWgr69lC";
    NSString* code = @"Dj3hVEj6EYlt7twlKJIwEvKiBQtWCXR9bgGFML52zTJCubvGLQsxAFONQ6S3X0KD-N";
    
    OAuth2Credentials *OAuth = [[OAuth2Credentials alloc] init];
    //[OAuth initWithClientID: clientID withClientSecret: clientSecret withAccessCode: code];
    //[OAuth getAccessToken];
    //NSLog(@"TOKEN: %@", [OAuth accessToken]);
    globalToken = @"CoW3Wqx0rWPRLxa90MJGnmr0ZPtk8FoRaz9qD1GQsarA1Zz979MXUKaslqqxpfSM-N-N";
    
    TaskCollection* coll = [[TaskCollection alloc] init];
    [coll fetch];
    
    return 0;
}
