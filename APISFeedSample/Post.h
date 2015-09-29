//
//  Post.h
//  APISFeedSample
//
//  Created by 植田 洋次 on 2015/06/25.
//  Copyright (c) 2015年 Yoji Ueda. All rights reserved.
//

#import <Foundation/Foundation.h>
//FIXME: SDKをインポートする
//#import <AppiariesSDK/AppiariesSDK.h>

//FIXME: ABDBObjectを継承、protocolを指定
//@interface Post : ABDBObject <ABManagedProtocol>
@interface Post : NSObject

@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *imageObjectId;

+ (id)post;

@end
