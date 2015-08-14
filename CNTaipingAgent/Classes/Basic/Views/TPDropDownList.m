//
//  TPDropDownList.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-19.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

typedef enum {
    DropDirectionUp,
    DropDirectionDown
}DropDirection;

#import "TPDropDownList.h"
#import "TPDropCell.h"

@implementation TPDropData

@synthesize name;
@synthesize isSelected;
@end

@interface TPDropDownList () <UITableViewDataSource, UITableViewDelegate>
{
    BOOL isOpen;
    UIButton *button;
    CGRect originFrame;
}

@property (nonatomic, assign) DropDirection direction;
@property (nonatomic, strong) UITableView *tableview;

- (void)openTable;
- (void)closeTable;
@end

@implementation TPDropDownList
@synthesize tableview;
@synthesize direction;
@synthesize selectType;
@synthesize datas = _datas;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        isOpen = NO;
        originFrame = frame;
        self.datas = [NSArray array];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        [button setTitle:@"全部" forState:UIControlStateNormal];
        [button setTitleColor:TEXTCOLOR(@"0xffffff") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.backgroundColor = [UIColor redColor];
        
        tableview = [[UITableView alloc] initWithFrame:CGRectZero];
        tableview.delegate = self;
        tableview.dataSource = self;
        [self addSubview:tableview];
    }
    return self;
}

- (void)setDatas:(NSArray *)datas
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *string in datas)
    {
        TPDropData *data = [TPDropData new];
        data.name = string;
        data.isSelected = NO;
        [array addObject:data];
    }
    _datas = array;
}

- (void)buttonClick:(UIButton *)button
{
    if (!isOpen)
    {
        UIView *toView = [[UIApplication sharedApplication].delegate window].rootViewController.view;
        CGRect rect = [self convertRect:self.bounds toView:toView];
        
        if (rect.origin.y < 768 - 44*3-30) {
            direction = DropDirectionDown;
        } else {
            direction = DropDirectionUp;
        }
    }
    
    isOpen = !isOpen;
    
    [self setNeedsLayout];

    [tableview reloadData];
}

#pragma mark - UITableView and dataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   	static NSString* httpTableViewCellIdentefier = @"TPDropCell cell";
	TPDropCell* cell = [tableView dequeueReusableCellWithIdentifier:httpTableViewCellIdentefier];
	if (nil == cell) {
		cell = [[TPDropCell alloc] initWithStyle:UITableViewCellStyleValue1
                                 reuseIdentifier:httpTableViewCellIdentefier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
	}

    TPDropData *data = _datas[indexPath.row];
    cell.title.text = data.name;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPDropData *data = _datas[indexPath.row];
    NSString *name = data.name;
    
    if (selectType == DropSelectOne) {
        isOpen = NO;
        [self setNeedsLayout];
        [tableView reloadData];
        [button setTitle:name forState:UIControlStateNormal];
    } else if (selectType == DropSelectMore) {
        [tableView reloadData];
    }
}

- (void)openTable
{
    if (direction == DropDirectionDown)
    {
        CGRect frame = self.frame;
        frame.size.height += 44*3;
        [UIView animateWithDuration:.5 animations:^{
            self.frame = frame;
            tableview.frame = CGRectMake(0, 30, self.width, 44*3);
        }];
    }
    else if (direction == DropDirectionUp)
    {
        CGRect frame = originFrame;
        frame.origin.y -= 44*3;
        frame.size.height += 44*3;
        
        [UIView animateWithDuration:.5 animations:^{
            self.frame = frame;
            tableview.frame = CGRectMake(0, 0, self.width, 44*3);
            button.frame = CGRectMake(0, 44*3, self.width, 30);
        }];
    }
}

- (void)closeTable
{
    if (direction == DropDirectionDown)
    {
        [UIView animateWithDuration:.5 animations:^{
            self.frame = originFrame;
            CGRect frame = self.bounds;
            frame.size.height = 0;
            tableview.frame = frame;
        }];
    }
    else if (direction == DropDirectionUp)
    {
        [UIView animateWithDuration:.5 animations:^{
            self.frame = originFrame;
            button.frame = self.bounds;
            CGRect frame = self.bounds;
            frame.size.height = 0;
            tableview.frame = frame;
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!isOpen)
        [self closeTable];
    else if (isOpen)
        [self openTable];
}
@end
























