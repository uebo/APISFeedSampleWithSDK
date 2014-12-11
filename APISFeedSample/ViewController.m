//
//  ViewController.m
//  APISFeedSample
//
//  Created by 植田 洋次 on 2014/11/05.
//  Copyright (c) 2014年 Yoji Ueda. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
//TODO: AppiariesSDKのimport

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
//JSON APIから取得するデータを格納
@property (strong, nonatomic) NSArray *collections;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配列を初期化
    self.collections = [[NSMutableArray alloc] init];
    
    //RefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    
    [self refreshAction:nil];
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
    NSDictionary *dict = self.collections[(NSUInteger)indexPath.row];
    
    //cellのサイズ調整
    //http://stackoverflow.com/questions/24750158/autoresizing-issue-of-uicollectionviewcell-contentviews-frame-in-storyboard-pro
    cell.contentView.frame = cell.bounds;
    cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //cell画像（本来は画像データをキャッシュするのが好ましい）
    [cell.mainImageView setImage:nil];
    
    //画像データをFileオブジェクトから取得する
    //コレクションID
    NSString *collectionId = @"imageFile";
    
    //TODO: APIClientオブジェクトの作成とFileSDKの呼び出し

    
    //テキスト
    cell.commentLabel.text = dict[@"comment"];
    
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
    
    //コレクションID
    NSString *collectionId = @"post";
    
    //TODO: APIClientオブジェクトの作成

    //TODO: JSON Dataの条件を指定します。今回は絞込条件なし
    
    //TODO: JSONオブジェクトを取得する

}

@end
