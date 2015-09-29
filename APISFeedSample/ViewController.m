//
//  ViewController.m
//  APISFeedSample
//
//  Created by 植田 洋次 on 2014/11/05.
//  Copyright (c) 2014年 Yoji Ueda. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
//FIXME: SDKをインポートする
//#import <AppiariesSDK/AppiariesSDK.h>
#import "Post.h"
#import "ImageFile.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
//JSON APIから取得するデータを格納
@property (strong, nonatomic) NSArray *collections;
//取得した画像をキャッシュする領域
@property (strong, nonatomic) NSMutableDictionary *imageCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配列を初期化
    self.collections = [NSArray new];
    self.imageCache = [NSMutableDictionary new];
    
    //RefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    //FIXME: 初回画面呼び出し
//    [self refreshAction:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collections count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    //取り出し
    Post *post = self.collections[(NSUInteger)indexPath.row];
    
    //cellのサイズ調整
    //http://stackoverflow.com/questions/24750158/autoresizing-issue-of-uicollectionviewcell-contentviews-frame-in-storyboard-pro
    cell.contentView.frame = cell.bounds;
    cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //cell画像
    [cell.mainImageView setImage:nil];
    
    //キャッシュがある場合はキャッシュから読み込み、ない場合はFileオブジェクトを取得する
    if ([self.imageCache objectForKey:indexPath] != nil) {
        [cell.mainImageView setImage:[self.imageCache objectForKey:indexPath]];
    } else {
        //FIXME: 画像データをFileオブジェクトから取得する
        //ファイルの取得
//        ImageFile *imageFile = [ImageFile new];
//        imageFile.ID = post.imageObjectId;
//        [baas.file fetch:imageFile block:^(ABResult *result, ABError *error) {
//            if (error) {
//                NSLog(@"%@", error.description);
//            } else {
//                //ファイルオブジェクト生成
//                ImageFile *fetched = result.data;
//                //URLから画像ファイルを取得
//                [self processImageDataWithURLString:fetched.url andBlock:^(NSData *imageData) {
//                    //画像をCellに設定
//                    UIImage *image = [[UIImage alloc]initWithData:imageData];
//                    [cell.mainImageView setImage:image];
//                    //キャッシュ領域に保存
//                    [self.imageCache setObject:image forKey:indexPath];
//                }];
//            }
//        }];
    }
    
    //テキスト
    cell.commentLabel.text = post.comment;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.view.frame.size.width;
    return CGSizeMake(width, width);
}

#pragma mark - private
-(void)refreshAction:(id)sender
{
    [self.refreshControl beginRefreshing];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //FIXME:抽出条件を指定
//    ABQuery *query = [Post query];
////  ABQuery *query = [[Post query] where:@"comment" equalsTo:@"aaaa"];
//    
//    //DBを検索する
//    [baas.db findWithQuery:query block:^(ABResult *result, ABError *error) {
//        if (error) {
//            NSLog(@"%@", error.description);
//        } else {
//            NSLog(@"%@", result.data);
//            self.collections = result.data;
//            //テーブルを更新
//            [self.collectionView reloadData];
//        }
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [self.refreshControl endRefreshing];
//    }];    
}

- (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(q_main, ^{
            processImage(imageData);
        });
    });
}

@end
