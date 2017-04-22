//
//  CustomTableViewCell.m
//  YPReusableController
//
//  Created by zhiai on 16/2/23.
//  Copyright © 2016年 tyiti. All rights reserved.
//
#define VIEW_WIDTH self.contentView.frame.size.width
#import "CustomTableViewCell.h"
#import "ListModel.h"
@implementation CustomTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.listpicimg = [UIImageView new];
        self.timeLabel = [UILabel new];
        self.titleLabel = [UILabel new];
        self.lessInforLabel = [UILabel new];
        self.fcnumberLabel = [UILabel new];
        self.PhotoCount = [UILabel new];
        
        self.ThreeimgTitleLabel = [UILabel new];
        self.ThreeimgFirstimg = [UIImageView new];
        self.ThreeimgSecimg = [UIImageView new];
        self.ThreeimgThirdimg = [UIImageView new];
        
        self.ThreeimgTitleLabel.frame = CGRectMake(5, 2, VIEW_WIDTH-2, 30);

        self.ThreeimgTitleLabel.font = [UIFont systemFontOfSize:18];
      

        [self.contentView addSubview:self.ThreeimgTitleLabel];
        [self.contentView addSubview:self.ThreeimgFirstimg];
        [self.contentView addSubview:self.ThreeimgSecimg];
        [self.contentView addSubview:self.ThreeimgThirdimg];
        
        [self.ThreeimgFirstimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.bottom.mas_equalTo(-30);
            make.width.mas_equalTo(self.ThreeimgSecimg);
            make.height.mas_equalTo(90);
        }];
        [self.ThreeimgThirdimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.bottom.mas_equalTo(-30);
            make.width.mas_equalTo(self.ThreeimgFirstimg);
            make.height.mas_equalTo(90);
        }];
        [self.ThreeimgSecimg mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(-30);
            make.left.equalTo(self.ThreeimgFirstimg.mas_right).offset(5);
            make.right.equalTo(self.ThreeimgThirdimg.mas_left).offset(-5);
            make.width.mas_equalTo(self.ThreeimgThirdimg);
            make.height.mas_equalTo(90);
        }];
        
        
        
        self.PhotoCount.font = [UIFont systemFontOfSize:12];
        self.PhotoCount.textColor = [UIColor lightGrayColor];
        
        self.listpicimg.frame = CGRectMake( 2 , 5, 138 , 95 );
        self.titleLabel.frame = CGRectMake( VIEW_WIDTH - 168 , 2 , 240 , 30 );
        self.titleLabel.font = [UIFont systemFontOfSize: 18 ];
        self.titleLabel.numberOfLines = 0;
        self.lessInforLabel.frame = CGRectMake(VIEW_WIDTH - 168, 32, 240, 40);
        self.lessInforLabel.font = [UIFont systemFontOfSize:14];
        self.lessInforLabel.numberOfLines = 0 ;
        self.lessInforLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.frame = CGRectMake( VIEW_WIDTH - 20 , 80 , 98 , 20 );
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.fcnumberLabel.frame = CGRectMake( VIEW_WIDTH -50,80, 80 ,20);
        self.fcnumberLabel.font = [UIFont systemFontOfSize:12];
        self.fcnumberLabel.textColor = [UIColor lightGrayColor];
        self.fcnumberLabel.textAlignment = NSTextAlignmentRight;

        [self.contentView addSubview:self.listpicimg];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.fcnumberLabel];
        [self.contentView addSubview:self.lessInforLabel];
        [self.contentView addSubview:self.PhotoCount];
        [self.listpicimg mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(4);
            make.left.mas_equalTo(2);
            make.bottom.mas_equalTo(-4);
            make.size.width.mas_equalTo(138);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(3);
            make.right.mas_equalTo(-5);
            make.left.mas_equalTo(self.listpicimg.mas_right).offset(5);
            make.height.mas_equalTo(30);
//            make.size.mas_equalTo(CGSizeMake(240, 30));
        }];
        [self.lessInforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
            make.right.mas_equalTo(-5);
            make.left.mas_equalTo(self.listpicimg.mas_right).offset(5);
//            make.size.mas_equalTo(CGSizeMake(240, 40));
            make.height.mas_equalTo(40);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.bottom.mas_equalTo(-3);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        [self.fcnumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.timeLabel.mas_left).offset(-5);
            make.bottom.mas_equalTo(-3);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        [self.PhotoCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.fcnumberLabel.mas_right).offset(-5);
            make.bottom.mas_equalTo(-3);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        
        
       
    }
    return self;
    
    
}
- (void)awakeFromNib {
    // Initialization code
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
