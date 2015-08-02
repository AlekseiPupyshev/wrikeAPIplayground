//
//  wrikeSDK.m
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 02/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface OAuth2Credentials : NSObject
{
    NSString *accesToken;
    NSString *refreshToken;
    NSString *clientID;
    NSString *clientSecret;
}
+ (void)initWithAccessCode: (NSString *) code;
+ (void)refreshToken;
@end
