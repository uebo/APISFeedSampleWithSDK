//
// Created by Appiaries Corporation on 2015/02/22.
// Copyright (c) 2015 Appiaries Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ABResultExtraRequestKey              @"_request"
#define ABResultExtraResponseKey             @"_response"
#define ABResultExtraDownloadFilePathKey   @"_download_filepath"


@class ABError;

/*!
結果オブジェクト
 */
@interface ABResult : NSObject
#pragma mark - Properties
/*! @name Properties */
/*!
 パース済み JSON レスポンス
 @discussion REST API から返却されたオブジェクトデータが格納されます。複数オブジェクトが返却された場合は、NSArray 形式でデータが格納されます。
 */
@property (strong, nonatomic) id data;
/*!
 JSON レスポンス
 @discussion REST API から返却された生のレスポンスが格納されます。
 @deprecated This property has been deprecated. Use downloadFilePath instead.
 */
@property (strong, nonatomic) id rawData __attribute__ ((deprecated("use downloadFilePath instead")));
/*!
 ダウンロードファイル・パス
 @discussion ファイルをダウンロードした際にデバイス上のファイルパスが格納されます。
 @since 2.0.6
 */
@property (strong, nonatomic, readonly) NSString *downloadFilePath;
/*!
 レスポンス・コード
 @discussion ABStatus が格納されます。
 */
@property (nonatomic) NSInteger code;
/*!
 取得総件数
 */
@property (nonatomic) NSUInteger total;
/*!
 取得データの先頭インデックス
 */
@property (nonatomic) NSUInteger start;
/*!
 取得データの末尾インデックス
 */
@property (nonatomic) NSUInteger end;
/*!
 取得データの先頭インデックス以前にデータが存在するか (YES=存在する)
 */
@property (nonatomic, getter=hasPrevious) BOOL previous;
/*!
 取得データの末尾インデックス以降にデータが存在するか (YES=存在する)
 */
@property (nonatomic, getter=hasNext) BOOL next;
/*!
 拡張データ
 @discussion 任意用途で利用できるディクショナリです。
 */
@property (strong, nonatomic) NSMutableDictionary *extra;

@end