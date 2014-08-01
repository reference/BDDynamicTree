//
//  BDDynamicTreeNode.h
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

#import <Foundation/Foundation.h>

@interface BDDynamicTreeNode : NSObject

@property (nonatomic, assign) CGFloat       originX;            //坐标x
@property (nonatomic, strong) NSString      *name;              //名称
@property (nonatomic, strong) NSDictionary  *data;              //节点详细
@property (nonatomic, strong) NSArray       *subNodes;          //子节点
@property (nonatomic, strong) NSString      *fatherNodeId;      //父节点的id
@property (nonatomic, strong) NSString      *nodeId;            //当前节点id
@property (nonatomic, assign) BOOL          isDepartment;       //是否是部门
@property (nonatomic, assign) BOOL          isOpen;             //是否展开的

//检查是否根节点
- (BOOL)isRoot;

@end
