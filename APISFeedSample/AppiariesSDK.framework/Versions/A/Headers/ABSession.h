//
// Created by Appiaries Corporation on 2015/02/22.
// Copyright (c) 2015 Appiaries Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ABDevice;
@class ABUser;
@class ABTwitterSession;
//@class ABFacebookSession;

/*!
 セッション
 */
@interface ABSession : NSObject
#pragma mark - Properties
/*! @name Properties */
/*!
 登録済みデバイス
 @discussion (アプリを起動中の)デバイス情報が登録された場合に、当該デバイス情報が格納されます。
 */
@property (strong, nonatomic, readonly) ABDevice *device;
/*!
 ログイン中ユーザ
 @discussion ログイン(またはサインアップ)した場合に、当該ユーザ情報が格納されます。
 */
@property (strong, nonatomic, readonly) ABUser *user;
/*!
 ストアトークン
 @discussion ログイン(またはサインアップ)に成功した場合に、当該ユーザに対して発行されたストアトークンが格納されます。
 */
@property (strong, nonatomic, readonly) NSString *token;
/*!
 Twitter セッション
 @discussion Twitter アカウントを利用してログインに成功した場合に Twitter セッション情報が格納されます。
 */
@property (weak, nonatomic, readonly) ABTwitterSession *twitter;
//@property (weak, nonatomic) ABFacebookSession *facebook;

#pragma mark - Initialization
/*! @name Initialization */
+ (instancetype)sharedSession;

#pragma mark - Instance methods
/*! @name Instance methods */
/*!
 登録済みデバイス情報を格納する
 @discussion 登録済みデバイス情報をセッションに格納します。
 @param device 登録済みデバイス
 */
- (void)storeDevice:(ABDevice *)device;
/*!
 登録済みデバイス情報を格納する
 @discussion 登録済みデバイス情報をセッションに格納します。
 @param device 登録済みデバイス
 @param isPermanently セッションに格納した内容を永続化するか (YES=永続化する)
 */
- (void)storeDevice:(ABDevice *)device isPermanently:(BOOL)isPermanently;
/*!
 ログイン中ユーザ情報を格納する
 @discussion ログイン中ユーザ情報をセッションに格納します。
 @param user ログイン中ユーザ
 */
- (void)storeUser:(ABUser *)user;
/*!
 ログイン中ユーザ情報を格納する
 @discussion ログイン中ユーザ情報をセッションに格納します。
 @param user ログイン中ユーザ
 @param isPermanently セッションに格納した内容を永続化するか (YES=永続化する)
 */
- (void)storeUser:(ABUser *)user isPermanently:(BOOL)isPermanently;
/*!
 ストアトークン
 @discussion ストアトークンを格納します。
 @param token ストアトークン
 */
- (void)storeToken:(NSString *)token;
/*!
 ストアトークン
 @discussion ストアトークンを格納します。
 @param token ストアトークン
 @param isPermanently セッションに格納した内容を永続化するか (YES=永続化する)
 */
- (void)storeToken:(NSString *)token isPermanently:(BOOL)isPermanently;
/*!
 ログイン中か
 @discussion ログインかどうかを返します。
 @return YES:ログイン中, NO:非ログイン中
 */
- (BOOL)isLoggedIn;
/*!
 デバイスは登録済みか
 @discussion アプリを実行中のデバイスがアピアリーズに登録済みかどうかを返します。
 @return YES:登録済み, NO:未登録
 */
- (BOOL)isRegisteredDevice;
/*!
 登録済みデバイスを破棄する
 @discussion セッションに格納されているデバイス情報を破棄します。
 */
- (void)invalidateDevice;
/*!
 ストアトークンを破棄する
 @discussion セッションに格納されているストアトークンを破棄します。
 */
- (void)invalidateToken;
/*!
 ログイン中ユーザ情報を破棄する
 @discussion セッションに格納されているログイン中ユーザ情報を破棄します。
 */
- (void)invalidateUser;
/*!
 Tiwtter セッション情報を破棄する
 @discussion セッションに格納されている Twitter セッション情報を破棄します。
 */
- (void)invalidateTwitter;
/*!
 すべてのセッション情報を破棄する
 @discussion セッションに格納されているすべての情報を破棄します。
 */
- (void)invalidateAll;

@end