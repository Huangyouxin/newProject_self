//
//  TPLSearchViewController.m
//  CNTaiPingAgent
//
//  Created by Eric on 13-12-13.
//  Copyright (c) 2013年 Tai Ping. All rights reserved.
//

#import "TPSearchViewController.h"

@interface TPSearchViewController (){
    UIButton *searchbutton;
    UIButton *clearbutton;
}
@end

@implementation TPSearchViewController
@synthesize buttonConfirm;
@synthesize buttonClear;

- (UIButton *)buttonConfirm {
    return searchbutton;
}

-(UIButton *)buttonClear{

    return clearbutton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundView.image = [Image(@"search/searchBg.png") stretch];
    
    searchbutton = [self buttonFrame:CGRectMake(30, 110, 110, 37)
                             selctor:@selector(onSearchButtonEvent:)
                                         image:Image(@"search/searchBtn.png")
                                        simage:Image(@"search/searchBtn2.png")];
    [self.view addSubview:searchbutton];
    
    clearbutton = [self buttonFrame:CGRectMake(160, 110, 110, 37)
                            selctor:@selector(onClearButtonEvent:)
                              image:Image(@"search/clearBtn.png")
                             simage:Image(@"search/clearBtn2.png")];
    [self.view addSubview:clearbutton];
    
    self.tableview.frame = CGRectMake(0, 180, self.view.width, self.view.height-180);
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.separatorColor = [UIColor clearColor];
    self.tableview.backgroundColor = [UIColor clearColor];
    __weak typeof(self) Self = self;
    [self.view addLayoutBlock:^{
        Self.tableview.frame = CGRectMake(0, 180, Self.view.width, Self.view.height-180);
    }];
    
}

-(void)hideLefeViewMsg:(NSNotification *)notification{

}

- (void)dealloc
{
}

- (void)onSearchButtonEvent:(UIButton *)btn
{
    NSLog(@"--------------------onSearchButtonEvent--------");
}

- (void)onClearButtonEvent:(UIButton *)btn
{
    NSLog(@"--------------------onClearButtonEvent--------");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self.view findFirstResponder] resignFirstResponder];
}

- (UIButton *)buttonFrame:(CGRect)frame
                  selctor:(SEL)selctor
                    image:(UIImage *)image
                   simage:(UIImage *)himage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:himage forState:UIControlStateSelected];
    [button addTarget:self action:selctor forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (NSMutableString *)nsstringFromcellSelectArray:(NSArray *)arrayValue{
    NSMutableString *itemStr = [NSMutableString string];
    for (int i = 0; i < arrayValue.count; i++) {
        [itemStr appendString:arrayValue[i]];
        [itemStr appendString:@","];
    }
    if (itemStr.length) {
        [itemStr deleteCharactersInRange:NSMakeRange(itemStr.length-1, 1)];
    }
    if (itemStr.length == 0) {
        [itemStr appendString:@""];
    }
    return itemStr;
}

-(NSArray *) getArrayFromBOString: (NSString *)string {
    NSMutableArray *array = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@","]];
    if (array.count > 0){
        NSString *string = array[0];
        if (string.length == 0) {
            [array removeObject: [array objectAtIndex:0]];
        }
    }
    return array;
}

#pragma mark UITableViewDelegate and UITableViewDataSource
- (void) checkNullRecords {}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString* httpTableViewCellIdentefier = @"contact";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:httpTableViewCellIdentefier];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:httpTableViewCellIdentefier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    cell.textLabel.text = [NSString stringWithFormat:@"row=%d",indexPath.row];
	return cell;
}


@end
