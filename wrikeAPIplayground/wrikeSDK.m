//
//  wrikeSDK.m
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 02/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "wrikeModels.h"

NSString* globalToken;

@implementation Requests

- (NSData*) makeGETRequest: (NSString*) requestURL : (NSString*) params {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setHTTPMethod: @"GET"];
    [request setHTTPShouldHandleCookies: YES];
    if([params isEqualToString: @""]) [request setURL: [NSURL URLWithString: requestURL]];
    else [request setURL: [NSURL URLWithString: [NSString stringWithFormat: @"%@?%@", requestURL, params]]];
    NSString* headerTokenField = [NSString stringWithFormat: @"bearer %@", globalToken];
    [request addValue: headerTokenField forHTTPHeaderField: @"Authorization"];
    
    NSData* responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    return responseData;
}

- (NSData*) makePOSTRequest: (NSString *) requestURL : (NSString *) params {
    NSData* postData = [params dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setURL: [NSURL URLWithString: [NSString stringWithFormat: @"%@?%@", requestURL, params]]];
    [request setHTTPMethod: @"POST"];
    [request setValue: [NSString stringWithFormat: @"%lu", (unsigned long)[params length]] forHTTPHeaderField: @"Content-Lenght"];
    [request setHTTPBody: postData];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    return responseData;
}

@end

@implementation TaskCollection

- (void) fetch {
    Requests* request = [[Requests alloc] init];

    NSData* responseData = [request makeGETRequest: @"https://www.wrike.com/api/v3/tasks" : @""];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSArray* array = [responseDict objectForKey: @"data"];
        
        [array enumerateObjectsUsingBlock: ^(NSDictionary* object, NSUInteger idx, BOOL* stop) {
            Task* task = [[Task alloc] init];
            
            task._id = [object objectForKey: @"id"];
            task.title = [object objectForKey: @"title"];
            task.Description = [object objectForKey: @"description"];
            task.briefDescription = [object objectForKey: @"briefDescription"];
            //task.parentsIds = pIds;
            task.updatedDate = [object objectForKey: @"createdData"];
            task.createdDate = [object objectForKey: @"updatedData"];
            
            [_items addObject: task];
        }];
    }
    
    NSLog(@"%@", [[NSString alloc] initWithData: responseData encoding: NSUTF8StringEncoding]);
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
    Requests* request = [[Requests alloc] init];
    
    NSData* responseData = [request makeGETRequest: @"https://www.wrike.com/api/v3/tasks/" : __id];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData: responseData encoding: NSUTF8StringEncoding]);
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSArray* array = [responseDict objectForKey: @"data"];
        
        [array enumerateObjectsUsingBlock: ^(NSDictionary* object, NSUInteger idx, BOOL* stop) {
            __id = [object objectForKey: @"id"];
            _title = [object objectForKey: @"title"];
            _Description = [object objectForKey: @"description"];
            _briefDescription = [object objectForKey: @"briefDescription"];
            // Должен получать массив, получает строку !!!
            //_parentsIds = [object objectForKey: @"parentsIds"];
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

- (void) createCommentWithText: (NSString *) text andWithTaskId: (NSString *) taskId {
    Requests* request = [[Requests alloc] init];
    
    NSData* responseData = [request makePOSTRequest: [NSString stringWithFormat: @"https://www.wrike.com/api/v3/tasks/%@/comments", taskId] : [NSString stringWithFormat: @"plainText=true&text=%@", text]];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSArray* array = [responseDict objectForKey: @"data"];
        
        [array enumerateObjectsUsingBlock: ^(NSDictionary* object, NSUInteger idx, BOOL* stop) {
            __id = [object objectForKey: @"id"];
            _authorId = [object objectForKey: @"authorid"];
            _text = [object objectForKey: @"text"];
            _updatedDate = [object objectForKey: @"updatedDate"];
            _taskId = [object objectForKey: @"taskId"];
        }];
    }
    NSLog(@"DATA: %@", [[NSString alloc] initWithData: responseData encoding: NSUTF8StringEncoding]);
}

@end

@implementation CommentsCollection

- (void) fetchCommentsByTaskId: (NSString *) taskId {
    Requests* request = [[Requests alloc] init];
    
    NSData* responseData = [request makeGETRequest: @"https://www.wrike.com/api/v3/comments/" : [NSString stringWithFormat: @"%@?plainText=true", taskId]];
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

- (void) initWithClientID: (NSString *) cID
         withClientSecret: (NSString *) cSecret
           withAccessCode: (NSString *) aCode {
    _clientID = cID;
    _clientSecret = cSecret;
    _accessCode = aCode;
}

- (void) getAccessToken {
    Requests* request = [[Requests alloc] init];
    
    NSData* responseData = [request makePOSTRequest: @"https://www.wrike.com/oauth2/token" : [NSString stringWithFormat: @"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@", _clientID, _clientSecret, _accessCode]];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        _accessToken = [responseDict objectForKey: @"access_token"];
        globalToken = _accessToken;
        _refreshToken = [responseDict objectForKey: @"refresh_token"];
    }
}

- (void) refreshToken {
    Requests* request = [[Requests alloc] init];
    
    NSData* responseData = [request makePOSTRequest: @"https://www.wrike.com/oauth2/token" : [NSString stringWithFormat: @"client_id=%@&client_secret=%@&grant_type=refresh_token&refresh_token=%@", _clientID, _clientSecret, _refreshToken]];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        _accessToken = [responseDict objectForKey: @"access_token"];
        _refreshToken = [responseDict objectForKey: @"refresh_token"];
    }
}
@end

