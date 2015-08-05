//
//  wrikeSDK.m
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 02/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "wrikeModels.h"

NSString* stringData = @"{ \"kind\": \"task\", \"data\": [ { \"id\": \"IEAAALNZKQAC2XZF\", \"title\": \"Test task\", \"description\": \"\", \"briefDescription\": \"\", \"parentsIds\": [ \"IEAAALNZI4AC2XZD\"], \"createdData\": \"2015-06-11T18:09:40Z\", \"updatedData\": \"2015-06-11T18:09:43Z\" } ] } }";

@implementation TaskCollection

- (void) fetch {
    NSData* responseData = [stringData dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSArray* array = [responseDict objectForKey: @"data"];
        
        [array enumerateObjectsUsingBlock: ^(NSDictionary* object, NSUInteger idx, BOOL* stop) {
            Task* task = [[Task alloc] init];
            task._id = [object objectForKey: @"id"];
            task.title = [object objectForKey: @"title"];
            task.Description = [object objectForKey: @"description"];
            task.briefDescription = [object objectForKey: @"briefDescription"];
            // Должен получать массив, получает строку !!!
            task.parentsIds = [object objectForKey: @"parentsIds"];
            // !!!
            task.updatedDate = [object objectForKey: @"createdData"];
            task.createdDate = [object objectForKey: @"updatedData"];
            
            [_items addObject: task];
            NSLog(@"%@", [task title]);
        }];
    }
}
/*
 Сначала создается объект NSData с JSON данными, затем
 создается словарь.
 После проверяем JSON на валидность и через блоки/замыкания 
 заполняем наш Task. Потом добовляем в массив
*/

@end

@interface OAuth2Credentials : NSObject {
    NSString *accesToken;
    NSString *refreshToken;
    NSString *clientID;
    NSString *clientSecret;
}

+ (void)initWithAccessCode: (NSString *) code withClientID: (NSString *) clientID
                withSecret: (NSString *) clientSecret;
+ (void)refreshToken;
@end

@implementation OAuth2Credentials
@end




