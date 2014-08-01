//
//  BDDynamicTree.m
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

#import "BDDynamicTree.h"
#import "BDDynamicTreeNode.h"
#import "BDDynamicTreeCell.h"

@interface BDDynamicTree () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    NSMutableArray *_nodesArray;
}
@end

@implementation BDDynamicTree

- (id)initWithFrame:(CGRect)frame nodes:(NSArray *)nodes
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataSource = [[NSMutableArray alloc] init];
        _nodesArray = [[NSMutableArray alloc] init];
        
        if (nodes && nodes.count) {
            [_nodesArray addObjectsFromArray:nodes];
            
            //添加根节点
            [_dataSource addObject:[self rootNode]];
        }
        
        //tableview
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return self;
}

#pragma mark - private methods

- (BDDynamicTreeNode *)rootNode
{
    for (BDDynamicTreeNode *node in _nodesArray) {
        if ([node isRoot]) {
            return node;
        }
    }
    return nil;
}

//添加子节点
- (void)addSubNodesByFatherNode:(BDDynamicTreeNode *)fatherNode atIndex:(NSInteger )index
{
    if (fatherNode)
    {
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *cellIndexPaths = [NSMutableArray array];
        
        NSUInteger count = index;
        for(BDDynamicTreeNode *node in _nodesArray) {
            if ([node.fatherNodeId isEqualToString:fatherNode.nodeId]) {
                node.originX = fatherNode.originX + 10/*space*/;
                [array addObject:node];
                [cellIndexPaths addObject:[NSIndexPath indexPathForRow:count++ inSection:0]];
            }
        }
        
        if (array.count) {
            fatherNode.isOpen = YES;
            fatherNode.subNodes = array;
            
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index,[array count])];
            [_dataSource insertObjects:array atIndexes:indexes];
            [_tableView insertRowsAtIndexPaths:cellIndexPaths withRowAnimation:UITableViewRowAnimationFade];
            [_tableView reloadData];
        }
    }
}

//根据节点减去子节点
- (void)minusNodesByNode:(BDDynamicTreeNode *)node
{
    if (node) {
        
        NSMutableArray *nodes = [NSMutableArray arrayWithArray:_dataSource];
        for (BDDynamicTreeNode *nd in nodes) {
            if ([nd.fatherNodeId isEqualToString:node.nodeId]) {
                [_dataSource removeObject:nd];
                [self minusNodesByNode:nd];
            }
        }
        
        node.isOpen = NO;
        [_tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDDynamicTreeNode *node = _dataSource[indexPath.row];
    CellType type = node.isDepartment?CellType_Department:CellType_Employee;
    return [BDDynamicTreeCell heightForCellWithType:type];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BDDynamicTreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:@"BDDynamicTreeCell" owner:self options:nil];
        cell = [topObjects objectAtIndex:0];
    }
    
    [cell fillWithNode:_dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BDDynamicTreeNode *node = _dataSource[indexPath.row];
    
    //callback
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicTree:didSelectedRowWithNode:)]) {
        [self.delegate dynamicTree:self didSelectedRowWithNode:node];
    }
    
    if (node.isDepartment) {
        if (node.isOpen) {
            //减
            [self minusNodesByNode:node];
        }
        else{
            //加一个
            NSUInteger index=indexPath.row+1;
            
            [self addSubNodesByFatherNode:node atIndex:index];
        }
    }
}

@end
