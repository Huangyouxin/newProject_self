//
//  TPDropCell.m
//  CNTaipingAgent
//
//  Created by Stone on 14-8-19.
//  Copyright (c) 2014年 Taiping. All rights reserved.
//

#import "TPDropCell.h"

@implementation TPDropCell

@synthesize title;
@synthesize selectImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 120, 30)];
        self.title.text = @"";
        self.title.textColor = TextBlackColor;
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.title];
        
        self.selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
        [self.contentView addSubview:self.selectImg];
    }
    
    return self;
}
@end
