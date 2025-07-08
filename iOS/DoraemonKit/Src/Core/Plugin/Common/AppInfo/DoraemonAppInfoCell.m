//
//  DoraemonAppInfoCell.m
//  DoraemonKit
//
//  Created by yixiang on 2018/4/14.
//

#import "DoraemonAppInfoCell.h"
#import "UIView+Doraemon.h"
#import "DoraemonDefine.h"
#import "UIColor+Doraemon.h"
#import "DoraemonDefine.h"

@interface DoraemonAppInfoCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation DoraemonAppInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            self.backgroundColor = [UIColor systemBackgroundColor];
        } else {
#endif
            self.backgroundColor = [UIColor whiteColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        }
#endif
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor doraemon_black_1];
        self.titleLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750_Landscape(32)];
        [self.contentView addSubview:self.titleLabel];
        
        self.valueLabel = [[UILabel alloc] init];
        self.valueLabel.textColor = [UIColor doraemon_black_2];
        self.valueLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750_Landscape(32)];
        self.valueLabel.numberOfLines = 0; // 关键，允许多行
        [self.contentView addSubview:self.valueLabel];
    }
    return self;
}

- (void)renderUIWithData:(NSDictionary *)data {
    NSString *title = data[@"title"];
    NSString *value = data[@"value"];
    
    self.titleLabel.text = title;
    
    NSString *cnValue = nil;
    if ([value isEqualToString:@"NotDetermined"]) {
        cnValue = DoraemonLocalizedString(@"用户没有选择");
    } else if ([value isEqualToString:@"Restricted"]) {
        cnValue = DoraemonLocalizedString(@"家长控制");
    } else if ([value isEqualToString:@"Denied"]) {
        cnValue = DoraemonLocalizedString(@"用户没有授权");
    } else if ([value isEqualToString:@"Authorized"]) {
        cnValue = DoraemonLocalizedString(@"用户已经授权");
    } else {
        cnValue = value;
    }
    
    self.valueLabel.text = cnValue;
    
    CGFloat cellHeight = [[self class] cellHeightWithData:data];
    
    CGFloat padding = kDoraemonSizeFrom750_Landscape(32);
    CGFloat maxContentWidth = DoraemonScreenWidth - 2 * padding - kDoraemonSizeFrom750_Landscape(200); // 200 预留 title 宽度
    
    CGSize valueSize = [self.valueLabel sizeThatFits:CGSizeMake(maxContentWidth, CGFLOAT_MAX)];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(padding, padding, self.titleLabel.doraemon_width, self.titleLabel.doraemon_height);
    
    self.valueLabel.frame = CGRectMake(DoraemonScreenWidth - padding - valueSize.width, padding, valueSize.width, valueSize.height);
}

+ (CGFloat)cellHeightWithData:(NSDictionary *)data {
    NSString *value = data[@"value"];
    NSString *cnValue = nil;
    if ([value isEqualToString:@"NotDetermined"]) {
        cnValue = DoraemonLocalizedString(@"用户没有选择");
    } else if ([value isEqualToString:@"Restricted"]) {
        cnValue = DoraemonLocalizedString(@"家长控制");
    } else if ([value isEqualToString:@"Denied"]) {
        cnValue = DoraemonLocalizedString(@"用户没有授权");
    } else if ([value isEqualToString:@"Authorized"]) {
        cnValue = DoraemonLocalizedString(@"用户已经授权");
    } else {
        cnValue = value;
    }
    
    CGFloat padding = kDoraemonSizeFrom750_Landscape(32);
    CGFloat maxContentWidth = DoraemonScreenWidth - 2 * padding - kDoraemonSizeFrom750_Landscape(200);
    
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.font = [UIFont systemFontOfSize:kDoraemonSizeFrom750_Landscape(32)];
    tempLabel.numberOfLines = 0;
    tempLabel.text = cnValue;
    
    CGSize valueSize = [tempLabel sizeThatFits:CGSizeMake(maxContentWidth, CGFLOAT_MAX)];
    
    CGFloat contentHeight = MAX(kDoraemonSizeFrom750_Landscape(104), valueSize.height + 2 * padding);
    return contentHeight;
}


@end
