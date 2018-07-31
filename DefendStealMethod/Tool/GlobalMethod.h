//
//  GlobalMethod.h
//  PregnantClothesGroup
//
//  Created by 张才维 on 2018/1/15.
//  Copyright © 2018年 zcw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




//用户的数据
#define kArchivingDataKey               @"currentUserInfo"
#define kArchivingFilePath              [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"multi.archiver"]

//是否登录
#define kIsLoginKey         @"kPCGisLogin"

@interface GlobalMethod : NSObject
//单例
+ (GlobalMethod *)shareMethod;


#pragma mark - 颜色
id colorWithHexString  (NSString *color);


#pragma mark - 提示
void showAlertHint (NSString * hint);
void showPCGHint (NSString *hint);
void showPCGTopHint(NSString * hint);

#pragma mark - 正则表达式验证
//验证手机号格式
bool checkTel(NSString * str);

//利用正则表达式验证邮箱
bool isValidateEmail(NSString *email);

//是否空值
NSString *getContentStr (id content_str, NSString *replace_str);

//检测字符串是否为空
+(BOOL)isEmptyString:(NSString *)check_str;

//判断是否是链接
-(BOOL)isUrl:(NSString *)contentString;

//判断字符是否为空  包括空格
+ (BOOL) isBlankString:(NSString *)string ;


#pragma makr - 将json转为字典
//将json转为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;
+ (NSString *)toJSONData:(id)theData;

#pragma mark - 设置导航栏
//设置导航栏
+(void)setNaviAppearance;




#pragma mark - userdefault
/**
 *  保存用户设置
 */
void saveUserSetting(NSString *key, id value);
/**
 *  获取用户设置
 */
id getSetting(NSString *key);
/**
 *  保存对象设置
 */
void saveObjectSetting(NSString *key, id value);
id getObjectSetting(NSString *key);


#pragma mark - 是否登录
/**
 *  是否登录
 *
 */
+ (BOOL) userIsLogin;



#pragma mark - 修正图片转向
+ (UIImage *)fixOrientation:(UIImage *)aImage;


//#pragma mark - 解档 和 归档 用户的个人信息
////解档
//+(PCGUserInfoModel *)customUnKeyedArchiverZUserInfoModel;
////归档
//+(void)customKeyedArchiverZUserInfoModel:(PCGUserInfoModel *)model;

#pragma mark - 根据id来解析出省市区的name
+(NSString *)parseNameWithId:(NSString *)id;


#pragma mark - 属性字符串
//设置属性字符串

+(NSMutableAttributedString *)setAttributedString:(NSString *)text
                                       withRange1:(NSRange )range1
                                       withRange2:(NSRange )range2
                                   withTextColor1:(UIColor *)textColor1
                                   withTextColor2:(UIColor *)textColor2
                                        withFont1:(UIFont *)font1
                                        withFont2:(UIFont *)font2;
#pragma mark - 时间戳
NSString *convertStampToDate(NSString *stamp);
@end
