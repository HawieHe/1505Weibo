//
//  StatusModel.m
//  CD1505Weibo
//
//  Created by HeHui on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "StatusModel.h"

#import "PicUrlsModel.h"

@implementation StatusModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ct":@"created_at"};
    
}

- (void)setSource:(NSString *)source
{
    NSArray *arr = [source componentsSeparatedByString:@"</a>"];
    NSString *firstCp = arr.firstObject;
    
    NSArray *arr2 = [firstCp componentsSeparatedByString:@">"];
    _source = [@"来自:" stringByAppendingString:arr2.lastObject];
}

// <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>

// 微博 weibo.com


    
    // 如果是去年  2015-12-11
    // 如果是今年
    //1. 10秒之内  -- 刚刚
    //2. 10秒< t < 一分钟之内 xx秒前
    //3. 1分钟< t < 一个小时  xx分钟前
    //4. 1个小时< t < 今天  今天 xx时xx分xx秒
    //5. t是昨天 昨天 xx时xx分
    //6. 不是昨天但是  是今年 xx月xx日


- (NSString *)ct
{
    // 在这里将时间转换成需要显示的时间。
    // Wed Jan 06 14:02:00 +0800 2015
    
    // 将字符串转换成时间
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    dataFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"CN"];
    // 微博创建的时间
    NSDate *ctDate = [dataFormatter dateFromString:_ct];
    // 将微博创建的时间和现在时间对比，
    NSDate *nowDate = [NSDate date];
    
    // 日历
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSInteger unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 获取两个时间的差。
    NSDateComponents * components = [calender components:unit fromDate:ctDate toDate:nowDate options:NSCalendarWrapComponents];
    
    // 是否是今年
    
    NSString *timeShowStr = nil;
    
    if (components.year < 1) {
        // 就是今年
        if ([calender isDateInToday:ctDate]) {
            
            if (components.hour >= 1) {
                // 一小时前
                [dataFormatter setDateFormat:@"今天 HH时mm分ss秒"];
            }else {
                if (components.minute >=1) {
                    // 一分钟前
                    NSString *mstr = [NSString stringWithFormat:@"%ld分钟前",components.minute];
                    
                    [dataFormatter setDateFormat:mstr];
                }else {
                    // 一分之内
                    if (components.second >=10) {
                        // 10秒前
                        NSString *sStr = [NSString stringWithFormat:@"%ld秒前",components.second];
                        [dataFormatter setDateFormat:sStr];
                    }else {
                        // 10秒内
                        [dataFormatter setDateFormat:@"刚刚"];
                    }
                }
            }
            
        }else if ([calender isDateInYesterday:ctDate]) {
            // 昨天
            [dataFormatter setDateFormat:@"昨天 HH时mm分"];
        }else {
            [dataFormatter setDateFormat:@"MM月dd日"];
        }
        
    }else {
        // 如果不是今年
        
        [dataFormatter setDateFormat:@"yyyy年MM月dd日"];
    }
    timeShowStr = [dataFormatter stringFromDate:ctDate];
    
    
    return  timeShowStr;
}



/** 告诉pic_urls里面应该去装PicUrlsModel的对象*/

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls":@"PicUrlsModel"};
}




@end





