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

@interface Folder : NSObject

@property (nonatomic) NSString *_id;
@property (nonatomic) NSString *title;

+ (instancetype) fetchFolderById: (NSString*) folderID;
// этот мотод как раз и должен по id просто выдергивать фолдер с сервера
// тут еще нужно проверить что возвращвется указатель на объект а не сам объект
@end

@interface Task  : NSObject // работает с __attribute__((visibility("default"))) но без переменных

@property (nonatomic) NSString* _id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *Description; // Тут проблема "Readwrite"
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

@interface CommentsCollection : NSArray

@property (nonatomic) NSMutableArray *items;

- (void) fetchCommentsByTaskId: (NSString*) taskId;

@end

@interface OAuth2Credentials : NSObject <NSURLConnectionDelegate> {
    NSString* clientID;
    NSString* clientSecret;
    NSString* accessCode;
}

- (NSString*) getAccessCredentials: (NSString*) clientIDM
                                  : (NSString*) clientSecretM
                                  : (NSString*) accessCodeM;
@end


