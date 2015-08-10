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

@implementation TaskCollection

- (void) fetch {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setHTTPMethod: @"GET"];
    [request setHTTPShouldHandleCookies: NO];
    [request setURL: [NSURL URLWithString: @"https://www.wrike.com/api/v3/tasks"]];
    NSString* headerTokenField = [NSString stringWithFormat: @"bearer @", globalToken];
    [request setValue: headerTokenField forHTTPHeaderField: @"Authorization"];
    
    NSData* responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSArray* array = [responseDict objectForKey: @"data"];
        NSLog(@"Normal JSON");
        [array enumerateObjectsUsingBlock: ^(NSDictionary* object, NSUInteger idx, BOOL* stop) {
            Task* task = [[Task alloc] init];
            task._id = [object objectForKey: @"id"];
            task.title = [object objectForKey: @"title"];
            task.taskDescription = [object objectForKey: @"description"];
            task.briefDescription = [object objectForKey: @"briefDescription"];
            // Должен получать массив, получает строку !!!
            //task.parentsIds = [object objectForKey: @"parentsIds"];
            // !!!
            task.updatedDate = [object objectForKey: @"createdData"];
            task.createdDate = [object objectForKey: @"updatedData"];
            
            [_items addObject: task];
            NSLog(@"%@", task.title);
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
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setHTTPMethod: @"GET"];
    [request setURL: [NSURL URLWithString: [NSString stringWithFormat: @"https://www.wrike.com/api/v3/tasks/", __id]]];
    [request setValue: globalToken forKey: @"accessToken"];
    
    NSData* responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        NSArray* array = [responseDict objectForKey: @"data"];
        
        [array enumerateObjectsUsingBlock: ^(NSDictionary* object, NSUInteger idx, BOOL* stop) {
            __id = [object objectForKey: @"id"];
            _title = [object objectForKey: @"title"];
            _taskDescription = [object objectForKey: @"description"];
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

@implementation Comment

- (void) createCommentWithText: (NSString *) text andWithTaskId: (NSString *) taskId {
    NSString* response = [NSString stringWithFormat: @"https://www.wrike.com/api/v3/tasks/%@/comments", taskId];
    NSString* post = [NSString stringWithFormat: @"plainText=true&text=%@", text];
    NSData* postData = [post dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
     
    [request setURL: [NSURL URLWithString: response]];
    [request setHTTPMethod: @"POST"];
    [request setValue: [NSString stringWithFormat: @"%lu", (unsigned long)[post length]] forHTTPHeaderField: @"Content-Lenght"];
    [request setValue: globalToken forKey: @"access_token"];
    [request setHTTPBody: postData];
    
    NSData* responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
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
}

@end

@implementation CommentsCollection

- (void) fetchCommentsByTaskId: (NSString *) taskId {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setHTTPMethod: @"GET"];
    [request setURL: [NSURL URLWithString:[NSString stringWithFormat: @"https://www.wrike.com/api/v3/tasks/%@/comments?plainText=true", taskId]]];
    [request setValue: globalToken forHTTPHeaderField: @"access_token"];
    
    NSData* responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
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
    NSString* response = @"https://www.wrike.com/oauth2/token";
    NSString *post = [NSString stringWithFormat: @"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@", _clientID, _clientSecret, _accessCode];
    NSData *postData = [post dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL: [NSURL URLWithString: response]];
    [request setHTTPMethod: @"POST"];
    [request setValue: [NSString stringWithFormat: @"%lu", (unsigned long)[post length]] forHTTPHeaderField: @"Content-Lenght"];
    [request setHTTPBody: postData];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        _accessToken = [responseDict objectForKey: @"access_token"];
        globalToken = _accessToken;
        _refreshToken = [responseDict objectForKey: @"refresh_token"];
    }
}

- (void) refreshToken {
    NSString* response = @"https://www.wrike.com/oauth2/token";
    NSString *post = [NSString stringWithFormat: @"client_id=%@&client_secret=%@&grant_type=refresh_token&refresh_token=%@", _clientID, _clientSecret, _refreshToken];
    NSData *postData = [post dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL: [NSURL URLWithString: response]];
    [request setHTTPMethod: @"POST"];
    [request setValue: [NSString stringWithFormat: @"%lu", (unsigned long)[post length]] forHTTPHeaderField: @"Content-Lenght"];
    [request setHTTPBody: postData];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: nil];
    
    if([NSJSONSerialization isValidJSONObject: responseDict]) {
        _accessToken = [responseDict objectForKey: @"access_token"];
        _refreshToken = [responseDict objectForKey: @"refresh_token"];
    }
}
@end

