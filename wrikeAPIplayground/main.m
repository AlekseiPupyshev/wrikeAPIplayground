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
    NSString* responseStrData = [OAuth getAccessCredentials: clientID : clientSecret : code];
    NSData* responseData = [responseStrData dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSLog(@"AccessToken: %@ \n ExpiresIn: %@ \n RefreshToken: %@", [responseDict objectForKey: @"access_token"], [responseDict objectForKey: @"expires_in"], [responseDict objectForKey: @"refresh_token"]);
    } else {
        NSLog(@"JSON NON VALID");
    }
    
    
    return 0;
}
