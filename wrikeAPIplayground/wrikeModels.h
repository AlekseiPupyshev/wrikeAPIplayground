//
//  wrikeModels.h
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 04/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#ifndef wrikeAPIplayground_wrikeModels_h
#define wrikeAPIplayground_wrikeModels_h

#endif

extern NSString* globalToken;

@interface OAuth2Credentials : NSObject

@property (nonatomic) NSString* clientID;
@property (nonatomic) NSString* clientSecret;
@property (nonatomic) NSString* accessCode;
@property (nonatomic) NSString* accessToken;
@property (nonatomic) NSString* refreshToken;

- (void) initWithClientID: (NSString*) cID
         withClientSecret: (NSString*) cSecret
           withAccessCode: (NSString*) aCode;
- (void) getAccessToken;
- (void) makeRefreshToken;
@end

@interface Requests : NSObject

- (NSData*) makeGETRequest: (NSString*) requestURL : (NSString*) params;
- (NSData*) makePOSTRequest: (NSString*) requestURL : (NSString*) params;

@end

@interface Folder : NSObject

@property (nonatomic) NSString *_id;
@property (nonatomic) NSString *title;

+ (instancetype) fetchFolderById: (NSString*) folderID;
// этот мотод как раз и должен по id просто выдергивать фолдер с сервера
// тут еще нужно проверить что возвращвется указатель на объект а не сам объект
@end

@interface Task  : NSObject

@property (nonatomic) NSString* _id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *Description; // Тут проблема "Readwrite" т.к description зарезервированное слово
@property (nonatomic) NSString *briefDescription;
@property (nonatomic) NSArray *parentsIds; // тут фолдеры которые помечают таску (например теги языков программирования)
@property (nonatomic) NSString *updatedDate;
@property (nonatomic) NSString *createdDate;

+ (instancetype) fetchTaskById: (NSString*) taskID;
- (void) sync; // этот метод просто берет id экземпляра и подкачивает актуальную инфу с сервера и обновляет содержимое экземпляра

@end

@interface TaskCollection : NSArray

@property (nonatomic) NSMutableArray *items;

-(void) fetch; // Получает все таски и сохраняет в items.

@end

// Самый важный класс для приложения quizir
@interface Vomment : NSObject
@property (nonatomic) NSString *_id;
@property (nonatomic) NSString *authorId;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *updatedDate;
@property (nonatomic) NSString *taskId;

- (void) createCommentWithText: (NSString*) text andWithTaskId: (NSString*) taskId;

@end

@interface CommentsCollection : NSObject

@property (nonatomic) NSMutableArray *items;

- (void) fetchCommentsByTaskId: (NSString*) taskId;

@end

