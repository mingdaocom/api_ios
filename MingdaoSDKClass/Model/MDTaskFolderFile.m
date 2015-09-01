//
//  MDTaskFolderFile.m
//  MingdaoV2
//
//  Created by yyp on 15/8/25.
//  Copyright (c) 2015年 Mingdao. All rights reserved.
//

#import "MDTaskFolderFile.h"
#import "MDTaskFolder.h"
@implementation MDTaskFolderFile

- (MDTaskFolderFile *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.objectID = dic[@"fFileID"];
        self.objectName = dic[@"fFileName"];
        self.sort = [dic[@"sort"] integerValue];
        NSArray *folderArr = dic[@"folders"];
        NSMutableArray *folders = [NSMutableArray array];
        for (NSDictionary *d in folderArr) {
            MDTaskFolder *folder = [[MDTaskFolder alloc] initWithDictionary:d];
            [folders addObject:folder];
        }
        self.folders = folders;
    }
    return self;
}


- (id)copy
{
    MDTaskFolderFile *file = [[MDTaskFolderFile alloc] init];
    file.objectID = [self.objectID copy];
    file.objectName = [self.objectName copy];
    file.sort = self.sort;
    file.folders = [self.folders mutableCopy];
    return file;
}



@end
