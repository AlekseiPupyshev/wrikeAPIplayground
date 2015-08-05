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

@interface Task : NSObject
@property (nonatomic) NSString *_id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *description;
@property (nonatomic) NSString *briefDescription;
@property (nonatomic) NSArray *parentIds; // тут фолдеры которые помечают таску (например теги языков программирования)
@property (nonatomic) NSString *updatedDate;
@property (nonatomic) NSString *createdDate;
+ (instancetype) fetchTaskById: (NSString*) taskID;
- (void) sync; // этот метод просто берет id экземпляра и подкачивает актуальную инфу с сервера и обновляет содержимое экземпляра
@end

@interface TaskCollection : NSArray
@property (nonatomic) NSArray *items;
+ (void) fetch; //просто запрашивает все таски и сохраняет их в поле items
@end

// Самый важный класс для приложения quizir
@interface Comment : NSObject
@property (nonatomic) NSString *_id;
@property (nonatomic) NSString *authorId;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *updatedDate;
@property (nonatomic) NSString *taskId;
- (void) createCommentWithText: (NSString*) text andWithTaskId: (NSString*) taskId;
@end

@interface CommentsCollection : NSArray
@property (nonatomic) NSArray *items;
+ (void) fetchCommentsByTaskId: (NSString*) taskId;
@end


