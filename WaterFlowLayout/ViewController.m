//
//  ViewController.m
//  WaterFlowLayout
//
//  Created by 小爪乎黑 on 15/7/29.
//  Copyright (c) 2015年 李帅. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "WaterFolwLayout.h"


#define kSpacing 10
#define kColumn 3
#define kInsert 10
#define kWidth (self.view.frame.size.width - kSpacing * (kColumn-1) - kInsert * 2) / kColumn




@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowLayoutDeleage>

@property (nonatomic,strong)NSMutableArray *dataAray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 解析数据
    [self p_jsonData];
    
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    WaterFolwLayout *layout = [[WaterFolwLayout alloc] init];
    layout.itemSize = CGSizeMake(kWidth, kWidth);
    layout.sectionInsets = UIEdgeInsetsMake(kInsert, kInsert, kInsert, kInsert);
    layout.insertItemSpacing = kSpacing;
    layout.numberOfColumns = kColumn;
    layout.delegate = self;
    
    
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    cv.dataSource =self;
    cv.delegate =self;
    [self.view addSubview:cv];
    
    // 注册
    [cv registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
 
}
// 解析数据
- (void)p_jsonData
{
    // 初始化数组
    self.dataAray = [NSMutableArray array];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Data.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSLog(@"%@",data);
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
    
    for (NSDictionary *dict  in array) {
        Model *m = [[Model alloc] init];
        // KVC
        [m setValuesForKeysWithDictionary:dict];
        [self.dataAray addObject:m];
    }
    
    NSLog(@"%@",_dataAray);
    

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataAray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    
    Model *m = self.dataAray[indexPath.item];
    // 图片加载
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:m.thumbURL]];
    
    return  cell;




}



// 获取每一个item的高度
- (CGFloat)heightForItemIndexpath:(NSIndexPath *)indexPath
{
    Model *m = self.dataAray[indexPath.item];
    
    
    CGFloat h = (kWidth * m.height) / m.width;
    
    return h;


}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
