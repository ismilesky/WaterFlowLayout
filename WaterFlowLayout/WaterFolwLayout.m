//
//  WaterFolwLayout.m
//  WaterFlowLayout
//

//

#import "WaterFolwLayout.h"

@interface WaterFolwLayout()

@property (nonatomic,assign)NSUInteger numberOfItems; //item的数量

@property (nonatomic,strong)NSMutableArray *columnHeights;  //保存每一列的高度

@property (nonatomic,strong)NSMutableArray
* itemAttributes;   // item的属性数组（x y w h）

// 最长列索引
- (NSInteger)p_indexForLongestColumn;
// 最短列索引
- (NSInteger)p_indexforshortestColumn;

@end

@implementation WaterFolwLayout

// 懒加载
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        self.columnHeights = [NSMutableArray array];
    }
    return _columnHeights;

}

- (NSMutableArray *)itemAttributes
{
    if (!_itemAttributes) {
        self.itemAttributes = [NSMutableArray array];
    }
    return _itemAttributes;
}

// 最长列索引
- (NSInteger)p_indexForLongestColumn
{
    // 记录最长列索引位置
    NSInteger longestIndex = 0;
    
    // 最长高度
    CGFloat longestHight = 0;
    
    
    for (int i= 0; i < self.numberOfColumns; i++) {
        
        // 当前列高度
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        // 比较并保存
        if(currentHeight > longestHight)
        {
            longestHight = currentHeight;
            longestIndex = i;
        }
        
    }
    return  longestIndex;

}
// 最短列索引
- (NSInteger)p_indexforshortestColumn
{
    NSInteger shortestIndex = 0;
    CGFloat shortestHeight = MAXFLOAT;
    
    for (int i = 0; i < self.numberOfColumns; i++) {
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        if (currentHeight < shortestHeight) {
            shortestHeight = currentHeight;
            shortestIndex = i;
        }
    }
    return shortestIndex;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 加上top高度
    for (int i = 0; i < self.numberOfColumns; i++) {
        self.columnHeights[i] = @(self.sectionInsets.top);
    }
    
    // 获取item的数量
    self.numberOfItems =[self.collectionView numberOfItemsInSection:0];

    //为每一个item设置frame 和 indexPath
    
    for (int i = 0;i < self.numberOfItems; i++) {
        
        // 找最短列
        NSInteger shortesIndex = [self p_indexforshortestColumn];
        CGFloat shortestH = [self.columnHeights[shortesIndex] floatValue];
        
        // 计算y
        CGFloat detalY = shortestH + self.insertItemSpacing;
        // 计算x
        CGFloat detalX = self.sectionInsets.left + (self.itemSize.width +self.insertItemSpacing) * shortesIndex;
        
        // 生成indexPath
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 计算h
        CGFloat itemHeight = 0;
        if (_delegate && [_delegate respondsToSelector:@selector(heightForItemIndexpath:)]) {
            itemHeight = [_delegate heightForItemIndexpath:indexpath];
        }
        
        // 生成属性对象
        UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        
        // 设置frame
        layoutAttr.frame = CGRectMake(detalX, detalY, self.itemSize.width, itemHeight);
        
        // 装入数组
        [self.itemAttributes addObject:layoutAttr];
        
        //  更新高度
        self.columnHeights[shortesIndex] = @(detalY + itemHeight);
    }
}

- (CGSize)collectionViewContentSize
{
    // 获取最长列索引
    NSInteger longestIndex = [self p_indexForLongestColumn];
    // 获取最长高度
    CGFloat longestH = [self.columnHeights[longestIndex] floatValue];
    // 获取collectionView的Size
    CGSize contentSize = self.collectionView.frame.size;
    
    // 更改高度
    contentSize.height = longestH + self.sectionInsets.bottom;
    
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}



@end
