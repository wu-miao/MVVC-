//
//  ViewController.m
//  MVVC－缓存
//
//  Created by wumiao on 17/1/4.
//  Copyright © 2017年 wumiao. All rights reserved.
//

#import "ViewController.h"
#import "movicModel.h"
#import "movicViewModel.h"
#import "TableViewCell.h"
#import "single.h"
#import <MJRefresh/MJRefresh.h>

#define kDOUBANMOVIEURL @"http://api.douban.com/v2/movie/top250"

#define viewWidth self.view.bounds.size.width
#define viewheight self.view.bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;  //数据源

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"电影";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    movicViewModel *movicVM = [[movicViewModel alloc] init];
    [movicVM getData:kDOUBANMOVIEURL];
    movicVM.returnValueBlock = ^(id retuenValue){
        for (movicModel *model in retuenValue) {
            if (![self.dataArray containsObject:model]) {
                [self.dataArray addObject:model];
                [[single shareInstance].databaseHelper insertMovic:model];
            }
        }
        [self.tableView reloadData];
    };
}
- (void)search{
    NSArray *arr = [[single shareInstance].databaseHelper getAllMovic];
    NSLog(@"%@",arr);
}
- (void)delete{
    [[single shareInstance].databaseHelper deleteAllMovic];
}
#pragma mark ------tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark ------懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewheight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
