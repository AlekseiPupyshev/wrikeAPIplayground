//
//  wrikeSDK.m
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 02/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "wrikeModels.h"

// A8U2Boa0QMnXxp4ETm6gFSt1GW8UCWInMX86AfpJrbwBurUwx6NtqGhQEodTmhd3-N

NSString* stringData = @"{ \"kind\": \"task\", \"data\": [ { \"id\": \"IEAAALNZKQAC2XZF\", \"title\": \"Test task\", \"description\": \"\", \"briefDescription\": \"\", \"parentsIds\": [ \"IEAAALNZI4AC2XZD\"], \"createdData\": \"2015-06-11T18:09:40Z\", \"updatedData\": \"2015-06-11T18:09:43Z\" } ] } }";

@implementation TaskCollection

- (void) fetch {
    /*
     curl -g -X GET -H 'Authorization: bearer <access_token>' 'https://www.wrike.com/api/v3/tasks?metadata=
     */
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
    // (NSString)* fromID = __id;
    
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

@implementation Vomment

- (void) createCommentWithText: (NSString *)text andWithTaskId: (NSString *)taskId {
    /*
     curl -g -X POST -H 'Authorization: bearer <access_token>' -d 'plainText=true&text=Task comment' 'https://www.wrike.com/api/v3/tasks/IEAAALNZKQAC2XZH/comments'
    */
}

@end

@implementation CommentsCollection

- (void) fetchCommentsByTaskId: (NSString *) taskId {
    /*
     curl -g -X GET -H 'Authorization: bearer <access_token>' 'https://www.wrike.com/api/v3/tasks/IEAAALNZKQAC2XZH/comments?plainText=true'
    */
    
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

@implementation OAuth2Credentials

- (NSString*) getAccessCredentials: (NSString *) clientIDM
                                  : (NSString *) clientSecretM
                                  : (NSString *) accessCodeM {
    NSString* response = @"https://www.wrike.com/oauth2/token";
    NSString *post = [NSString stringWithFormat: @"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@", clientIDM, clientSecretM, accessCodeM];
    NSData *postData = [post dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL: [NSURL URLWithString: response]];
    [request setHTTPMethod: @"POST"];
    [request setValue: [NSString stringWithFormat: @"%lu", (unsigned long)[post length]] forHTTPHeaderField: @"Content-Lenght"];
    [request setHTTPBody: postData];
    
    NSData *oData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSDictionary *oDict = [NSJSONSerialization JSONObjectWithData: oData options: NSJSONReadingMutableContainers error: nil];
    
    return [[NSString alloc] initWithData: oData encoding: NSUTF8StringEncoding];
}
@end

