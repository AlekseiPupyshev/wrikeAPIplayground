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
            //task.parentsIds = [object objectForKey: @"parentsIds"];
            // !!!
            task.updatedDate = [object objectForKey: @"createdData"];
            task.createdDate = [object objectForKey: @"updatedData"];
            
            [_items addObject: task];
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

@implementation Task

-(void) sync {
    // Вначале нужно подрузить дату с _id экземпляра
    NSData* responseData = [stringData dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSArray* array = [responseDict objectForKey: @"data"];
        
        [array enumerateObjectsUsingBlock: ^(NSDictionary* object, NSUInteger idx, BOOL* stop) {
            __id = [object objectForKey: @"id"];
            _title = [object objectForKey: @"title"];
            _Description = [object objectForKey: @"description"];
            _briefDescription = [object objectForKey: @"briefDescription"];
            // Должен получать массив, получает строку !!!
            _parentsIds = [object objectForKey: @"parentsIds"];
            // !!!
            _updatedDate = [object objectForKey: @"createdData"];
            _createdDate = [object objectForKey: @"updatedData"];
        }];
    }
}
// Происходит тоже самое, что и в TaskCollection(fetch).

@end

@implementation Folder
/*
+ (instancetype) fetchFolderById: (NSString *) folderID {
    
}
*/
@end

@implementation CommentsCollection

- (void) fetchCommentsByTaskId: (NSString *) taskId {
    NSData* responseData = [stringData dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSArray* array = [responseDict objectForKey: @"data"];
        
        [array enumerateObjectsUsingBlock: ^(NSDictionary* object, NSUInteger idx, BOOL* stop) {
            Vomment* comment = [[Vomment alloc] init];
            comment._id = [object objectForKey: @"id"];
            comment.authorId = [object objectForKey: @"authorId"];
            comment.text = [object objectForKey: @"text"];
            comment.updatedDate = [object objectForKey: @"updatedDate"];
            comment.taskId = [object objectForKey: @"taskId"];
            
            [_items addObject: comment];
        }];
    }
}

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




