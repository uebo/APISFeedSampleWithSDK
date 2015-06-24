//
//  PostViewController.m
//  APISFeedSample
//
//  Created by 植田 洋次 on 2014/10/17.
//  Copyright (c) 2014年 Yoji Ueda. All rights reserved.
//

#import "PostViewController.h"
#import "UIImage+Extensions.h"
#import <AppiariesSDK/AppiariesSDK.h>

@interface PostViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButtonItem;

//選択した写真を一時的に保存する場所
@property (strong, nonatomic) UIImage *selectedImage;

- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;
- (IBAction)photoButtonAction:(id)sender;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonAction:(id)sender {
    
    //エラーチェック
    if (!self.selectedImage) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                        message:@"画像を選択して下さい"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.saveButtonItem.enabled = NO;

    //登録する画像
    NSData *imageData = UIImageJPEGRepresentation(self.selectedImage, 0.5);

    //コレクションID
    NSString *collectionId = @"imageFile";
    //ファイルを作成する
    ABFile *file = [ABFile fileWithCollectionID:collectionId];
    file.data = imageData;
    file.contentType = @"image/jpeg";
    [file saveWithBlock:^(ABResult *result, ABError *error) {
        if (error) {
            NSLog(@"%@", error.description);
            self.saveButtonItem.enabled = YES;
        } else {
            NSLog(@"%@",result.data);
            
            //resultオブジェクトからIDを取得
            NSString *objectId = result.data[@"_id"];;
            
            //JSONデータ作成処理へ
            [self postDataWithObjectId:objectId];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

- (void)postDataWithObjectId:(NSString*)objectId
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //コレクションID
    NSString *collectionId = @"post";
    
    //DBデータの作成
    ABDBObject *object = [ABDBObject objectWithCollectionID:collectionId];
    object[@"imageObjectId"] = objectId ?:@"";
    object[@"comment"] = self.commentTextView.text ?:@"";
    object[@"createdAt"] = [NSNumber numberWithUnsignedLong:(unsigned long)[[NSDate date] timeIntervalSince1970]];
    
    [object saveWithBlock:^(ABResult *result, ABError *error) {
        if (error) {
            NSLog(@"error: %@",error.description);
        } else {
            //成功表示
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功!"
                                                            message:@"登録しました！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            //閉じる
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.saveButtonItem.enabled = YES;
    }];
}

- (IBAction)photoButtonAction:(id)sender {
    // カメラのアクションシートを作る
    UIActionSheet*  sheet;
    sheet = [[UIActionSheet alloc]
             initWithTitle:@"Choose"
             delegate:self
             cancelButtonTitle:@"Cancel"
             destructiveButtonTitle:nil
             otherButtonTitles:@"Library",@"Camera", nil];
    [sheet showInView:self.view];
}

//--------------------------------------------------------------//
#pragma mark -- UIActionSheetDelegate --
//--------------------------------------------------------------//
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // ボタンインデックスをチェックする
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    // ソースタイプを決定する
    UIImagePickerControllerSourceType   sourceType = 0;
    switch (buttonIndex) {
        case 0: {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        case 1: {
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
    }
    
    // 使用可能かどうかチェックする
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:NSLocalizedString(@"ImagePickerNotAccess", nil)
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // イメージピッカーを作る
    UIImagePickerController*    imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType    = sourceType;
    imagePicker.delegate      = self;
    
    // イメージピッカーを表示する
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//--------------------------------------------------------------//
#pragma mark -- UIImagePickerDelegate --
//--------------------------------------------------------------//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //加工された画像を取得
    UIImage *image = [[info objectForKey:UIImagePickerControllerOriginalImage] fixOrientation];
    self.selectedImage = [image imageByCroppingSquare];
    //ボタンに画像を配置
    [self.photoButton setImage:self.selectedImage forState:UIControlStateNormal];
    [self.photoButton setTitle:@"" forState:UIControlStateNormal];
    
    // イメージピッカーを隠す
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker{
    // イメージピッカーを隠す
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
