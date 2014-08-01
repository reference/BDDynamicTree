//
//  BDDynamicTreeCell.m
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

#import "BDDynamicTreeCell.h"

#define DepartmentCellHeight 44
#define EmployeeCellHeight  60

@interface BDDynamicTreeCell ()
@end

@implementation BDDynamicTreeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.avatarImageView.layer.cornerRadius = 5.f;
    self.avatarImageView.layer.masksToBounds = YES;
}

+ (CGFloat)heightForCellWithType:(CellType)type
{
    if (type == CellType_Department) {
        return DepartmentCellHeight;
    }
    return EmployeeCellHeight;
}

- (void)fillWithNode:(BDDynamicTreeNode*)node
{
    if (node) {
        NSInteger cellType = node.isDepartment;
        
        [self setCellStypeWithType:cellType originX:node.originX];
        
        if (cellType == CellType_Department) {
            if ([node isRoot]) {
                self.labelTitle.text = [NSString stringWithFormat:@"%@",node.name];
            }else{
                self.labelTitle.text = [NSString stringWithFormat:@"%@(%lu)",node.name,(unsigned long)node.subNodes.count];
            }
            
            if (node.isOpen) {
                self.plusImageView.image = [UIImage imageNamed:@"icon_minus"];
            }
        }
        else{
            NSDictionary *dic = node.data;
            self.labelTitle.text = dic[@"name"];
            
            self.avatarImageView.image = [UIImage imageNamed:@"2.jpg"];
        }
    }
}

- (void)setCellStypeWithType:(NSInteger)type originX:(CGFloat)x
{
    if (type == CellType_Department) {
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x,
                                            self.contentView.frame.origin.y,
                                            self.contentView.frame.size.width, DepartmentCellHeight);
        
        self.avatarImageView.hidden = YES;
        
        //设置 + 号的位置
        self.plusImageView.frame = CGRectMake(x, self.plusImageView.frame.origin.y,
                                              self.plusImageView.frame.size.width,
                                              self.plusImageView.frame.size.height);
        
        //设置 label的位置
        self.labelTitle.frame = CGRectMake(self.plusImageView.frame.origin.x+self.plusImageView.frame.size.width + 5/*space*/, 0,
                                           self.contentView.frame.size.width - self.plusImageView.frame.origin.x - self.plusImageView.frame.size.width - 5 - 5/*space*/,
                                           self.contentView.frame.size.height);
        
        //underline
        self.underLine.frame = CGRectMake(x,
                                          self.contentView.frame.size.height - 0.5,
                                          self.contentView.frame.size.width - x,
                                          0.5);
        self.underLine.backgroundColor = [UIColor colorWithRed:242/255.f green:244/255.f blue:246/255.f alpha:1];
        
    }
    else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x,
                                            self.contentView.frame.origin.y,
                                            self.contentView.frame.size.width, EmployeeCellHeight);
        
        self.plusImageView.hidden = YES;
        
        //设置头像的位置
        CGFloat iconWidth = EmployeeCellHeight - 10;
        self.avatarImageView.frame = CGRectMake(x, EmployeeCellHeight/2.f - iconWidth/2.f, iconWidth, iconWidth);
        
        //这是label
        self.labelTitle.frame = CGRectMake(self.avatarImageView.frame.origin.x+self.avatarImageView.frame.size.width + 5/*space*/,
                                           0,
                                           self.contentView.frame.size.width - self.avatarImageView.frame.origin.x - self.avatarImageView.frame.size.width - 5 - 5/*space*/,
                                           self.contentView.frame.size.height);
        
        //underline
        self.underLine.frame = CGRectMake(x,
                                          self.contentView.frame.size.height - 0.5,
                                          self.contentView.frame.size.width - x,
                                          0.5);
        self.underLine.backgroundColor = [UIColor colorWithRed:242/255.f green:244/255.f blue:246/255.f alpha:1];
    }
}

@end
