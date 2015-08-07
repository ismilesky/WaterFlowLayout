//
//  ViewController.m
//  WaterFlowLayout
//

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
    
    
    // 自定义布局
    WaterFolwLayout *layout = [[WaterFolwLayout alloc] init];
    layout.itemSize = CGSizeMake(kWidth, kWidth);
    layout.sectionInsets = UIEdgeInsetsMake(kInsert, kInsert, kInsert, kInsert);
    layout.insertItemSpacing = kSpacing;
    layout.numberOfColumns = kColumn;
    
    // 设置代理
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
        // KVC赋值 （字典转模型）
        [m setValuesForKeysWithDictionary:dict];
        [self.dataAray addObject:m];
    }
    
    NSLog(@"%@",_dataAray);
    

}

#prarm mark -  Methods of Delegate

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



// 获取每一个item的高度 (实现代理中的方法)
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
