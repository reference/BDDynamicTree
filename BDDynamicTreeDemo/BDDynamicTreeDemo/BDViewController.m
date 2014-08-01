//
//  BDViewController.m
//
//  Created by Scott Ban (https://github.com/reference) on 14/07/30.
//  Copyright (C) 2011-2020 by Scott Ban

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BDViewController.h"
#import "BDDynamicTreeNode.h"

@interface BDViewController ()
{
    BDDynamicTree *_dynamicTree;
}
@end

@implementation BDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dynamicTree = [[BDDynamicTree alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20) nodes:[self generateData]];
    _dynamicTree.delegate = self;
    [self.view addSubview:_dynamicTree];
}

- (NSArray *)generateData
{
    NSMutableArray *arr = [NSMutableArray array];
    
    //北京大洋国际科技有限公司
    BDDynamicTreeNode *root = [[BDDynamicTreeNode alloc] init];
    root.originX = 20.f;
    root.isDepartment = YES;
    root.fatherNodeId = nil;
    root.nodeId = @"node_1000";
    root.name = @"北京大洋国际科技有限公司";
    root.data = @{@"name":@"北京大洋国际科技有限公司"};
    
    [arr addObject:root];
    
    //财务部
    BDDynamicTreeNode *caiwu = [[BDDynamicTreeNode alloc] init];
    caiwu.isDepartment = YES;
    caiwu.fatherNodeId = @"node_1000";
    caiwu.nodeId = @"node_1100";
    caiwu.name = @"财务部";
    caiwu.data = @{@"name":@"财务部"};
    
    [arr addObject:caiwu];
    
    //市场部
    BDDynamicTreeNode *shichang = [[BDDynamicTreeNode alloc] init];
    shichang.isDepartment = YES;
    shichang.fatherNodeId = @"node_1000";
    shichang.nodeId = @"node_1200";
    shichang.name = @"市场部";
    shichang.data = @{@"name":@"市场部"};
    
    [arr addObject:shichang];
    
    //出纳部
    BDDynamicTreeNode *chuna = [[BDDynamicTreeNode alloc] init];
    chuna.isDepartment = YES;
    chuna.fatherNodeId = @"node_1100";
    chuna.nodeId = @"node_1110";
    chuna.name = @"出纳部";
    chuna.data = @{@"name":@"出纳部"};
    
    [arr addObject:chuna];
    
    //收银部
    BDDynamicTreeNode *shouyin = [[BDDynamicTreeNode alloc] init];
    shouyin.isDepartment = YES;
    shouyin.fatherNodeId = @"node_1100";
    shouyin.nodeId = @"node_1120";
    shouyin.name = @"收银部";
    shouyin.data = @{@"name":@"收银部"};
    
    [arr addObject:shouyin];
    
    //xiao娟
    BDDynamicTreeNode *lujuan = [[BDDynamicTreeNode alloc] init];
    lujuan.isDepartment = NO;
    lujuan.fatherNodeId = @"node_1120";
    lujuan.nodeId = @"node_1121";
    lujuan.name = @"小娟";
    lujuan.data = @{@"name":@"小娟",@"avatarUrl":@"http://www.baidu.com/lujuan.jpg"};
    
    [arr addObject:lujuan];
    
    //涛哥
    BDDynamicTreeNode *taoge = [[BDDynamicTreeNode alloc] init];
    taoge.isDepartment = NO;
    taoge.fatherNodeId = @"node_1120";
    taoge.nodeId = @"node_1122";
    taoge.name = @"涛哥";
    taoge.data = @{@"name":@"涛哥",@"avatarUrl":@"http://www.baidu.com/lujuan.jpg"};
    
    [arr addObject:taoge];
    
    return arr;
}

- (void)dynamicTree:(BDDynamicTree *)dynamicTree didSelectedRowWithNode:(BDDynamicTreeNode *)node
{
    if (!node.isDepartment) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你好，我的名字叫"
                                                        message:node.name
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"知道了", nil];
        [alert show];
    }
}

@end
