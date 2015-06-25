//
//  Post.m
//  APISFeedSample
//
//  Created by 植田 洋次 on 2015/06/25.
//  Copyright (c) 2015年 Yoji Ueda. All rights reserved.
//

#import "Post.h"

@implementation Post

@dynamic comment, imageObjectId;

//アピアリーズのコレクションIDを設定
+ (NSString*)collectionID { return @"post"; }

//イニシャライザ
+ (id)post { return [[self class] object]; }

@end
