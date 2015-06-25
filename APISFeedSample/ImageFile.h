//
//  ImageFile.h
//  APISFeedSample
//
//  Created by 植田 洋次 on 2015/06/25.
//  Copyright (c) 2015年 Yoji Ueda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppiariesSDK/AppiariesSDK.h>

@interface ImageFile : ABFile <ABManagedProtocol>

@property (nonatomic) CGSize size;

@end
