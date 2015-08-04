//
//  wrikeSDK.m
//  wrikeAPIplayground
//
//  Created by Alexey Pupyshev on 02/08/15.
//  Copyright (c) 2015 Alexey Pupyshev. All rights reserved.
//

#import <Foundation/Foundation.h>

// Модель акаунта
@interface AccountModel : NSObject {
    NSString* ID;
    NSString* name;
    NSString* rootFolderId;
    NSString* recycleBinId;
}

-(void) initWithID: (NSString*) ID
          withName: (NSString*) name
  withRootFolderId: (NSString*) rootFolderId
  withRecycleBinId: (NSString*) recycleBinId;

@end
@implementation AccountModel

-(void) initWithID: (NSString *) IDM
          withName: (NSString *) nameM
  withRootFolderId: (NSString *) rootFolderIdM
  withRecycleBinId: (NSString *) recycleBinIdM {
    ID = IDM;
    name = nameM;
    rootFolderId = rootFolderIdM;
    recycleBinId = recycleBinIdM;
}

@end

// Коллекция аккаунтов
@interface AccountsCollection : NSObject {
    NSMutableArray* collection;
}

-(void) addAccount: (AccountModel*) account;
-(NSMutableArray*) getAccounts;

@end
@implementation AccountsCollection

-(void) addAccount: (AccountModel*) account {
    [collection addObject: account];
}

-(NSMutableArray*) getAccounts {
    return collection;
}

@end

// Коллекция ветки папок
@interface FolderTreeCollection : NSObject {
    NSMutableArray* collection;
}

-(void) addToFolderToTree: (FolderModel*) folder;
-(NSMutableArray*) getFolderTree;

@end
@implementation FolderTreeCollection

-(void) addToFolderToTree: (FolderModel*) folder {
    [collection addObject: folder];
}

-(NSMutableArray*) getFolderTree {
    return collection;
}

@end

// Модель папки
@interface FolderModel : NSObject {
    NSString* ID;
    NSString* title;
    NSString* description;
    NSArray* parentIDs;
}

-(void) initFullWithID: (NSString*) IDM
             withTitle: (NSString*) titleM
       withDescription: (NSString*) descriptionM
         withParentIDs: (NSArray*) parentIDsM;

-(void) initForTreeWithID: (NSString*) IDM
                withTitle: (NSString*) titleM
             withChildIDs: (NSArray*) childIDsM
                withScope: (NSString*) scopeM;
@end
@implementation FolderModel

-(void) initWithID: (NSString *) IDM
         withTitle: (NSString *) titleM
   withDescription: (NSString *) descriptionM
     withParentIDs: (NSArray *) parentIDsM {
    ID = IDM;
    title = titleM;
    description = descriptionM;
    [parentIDs arrayByAddingObjectsFromArray: parentIDsM];
    childIDs = childIDsM;
}

@end

// Методы Wrike
@interface WrikeMethods : NSObject

+(AccountsCollection*) getAccounts;
+(FolderTreeCollection*) getFolderTree;
+(FolderModel*) getFolder: (NSString*) ID;

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
