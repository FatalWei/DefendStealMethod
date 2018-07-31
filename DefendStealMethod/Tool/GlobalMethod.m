//
//  GlobalMethod.m
//  PregnantClothesGroup
//
//  Created by 张才维 on 2018/1/15.
//  Copyright © 2018年 zcw. All rights reserved.
//

#import "GlobalMethod.h"

@implementation GlobalMethod

/*** 单例 ***/
static GlobalMethod *global = nil;
+ (GlobalMethod *)shareMethod
{
    @synchronized(self) {
        if (global == nil) {
            global = [[GlobalMethod alloc] init];
        }
    }
    return global;
}



//自定义颜色转换
id colorWithHexString  (NSString *color)
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark - 提示
void showAlertHint (NSString * hint)
{
    
    if (![hint isKindOfClass:[NSString class]]) {
        return;
    }
    
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
    
}


#pragma  孕衣派项目独有
void showPCGHint (NSString *hint){
    if (![hint isKindOfClass:[NSString class]]) {
        return;
    }
    UIView *view = [[UIApplication sharedApplication].delegate window];
//    PCGShowHintView *hintView = [[PCGShowHintView alloc]initWithHint:hint];
//    [view addSubview:hintView];
}

void showPCGTopHint(NSString * hint){
    if (![hint isKindOfClass:[NSString class]]) {
        return;
    }
    UIView *view = [[UIApplication sharedApplication].delegate window];
//    PCGShowTopHintView *hintView = [[PCGShowTopHintView alloc]initWithHint:hint];
//    [view addSubview:hintView];
}


#pragma mark  - 正则表达式验证
//验证手机号格式
bool checkTel(NSString * str)
{
    NSString *phoneRegex = @"1[3,4,5,7,8][0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}$";//@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:str];
}

//利用正则表达式验证邮箱
bool isValidateEmail(NSString *email)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isT = [emailTest evaluateWithObject:email];
    return isT;
}

//替换空值
NSString *getContentStr (id content_str, NSString *replace_str)
{
    if ([content_str isKindOfClass:[NSNull class]] || ![content_str isKindOfClass:[NSString class]] || [GlobalMethod isBlankString:content_str]) {
        return replace_str;
    }
    else
        return  content_str;
}





//======判断是否是链接=====
-(BOOL)isUrl:(NSString *)contentString{
    
    NSError *error;
    NSString *regulaStr = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:contentString options:0 range:NSMakeRange(0, [contentString length])];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [contentString substringWithRange:match.range];
        NSLog(@"%@",substringForMatch);
        return YES;
    }
    return NO;
}

+(BOOL)isEmptyString:(NSString *)check_str{
    BOOL isEmpty = NO;
    if ([check_str isKindOfClass:[NSNull class]] || ![check_str isKindOfClass:[NSString class]] || check_str.length == 0) {
        return YES;
    }
    return isEmpty;
}

//判断是否空值
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL || [string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


#pragma mark - 设置属性字符串
+(NSMutableAttributedString *)setAttributedString:(NSString *)text
                                       withRange1:(NSRange )range1
                                       withRange2:(NSRange )range2
                                   withTextColor1:(UIColor *)textColor1
                                   withTextColor2:(UIColor *)textColor2
                                        withFont1:(UIFont *)font1
                                        withFont2:(UIFont *)font2{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:text];
    
    //设置颜色
    [attri addAttribute:NSForegroundColorAttributeName value:textColor1 range:range1];
    [attri addAttribute:NSForegroundColorAttributeName value:textColor2 range:range2];
    //设置字体
    [attri addAttribute:NSFontAttributeName value:font1 range:range1];
    [attri addAttribute:NSFontAttributeName value:font2 range:range2];
    return attri;
}









#pragma mark toJSONData  ++++++++将字典或者数组转化为JSON串

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+ (NSString *)toJSONData:(id)theData{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}



#pragma mark - 设置导航栏
//设置导航栏
+(void)setNaviAppearance{
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        //背景色
        [[UINavigationBar appearance] setBarTintColor:NAVI_BACKGROUND_COLOR];
        //[UINavigationBar appearance].translucent = NO;
    }
    else{
        //背景色
        [[UINavigationBar appearance] setBarTintColor:NAVI_BACKGROUND_COLOR];
    }
    //上面的标题颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVI_TITLE_COLOR,NSFontAttributeName:PINGFANG_Regular_18}];
    //导航栏字体
    
    
    //上面的左右item的颜色
    [[UINavigationBar appearance] setTintColor:colorWithHexString(@"333333")];
    
    //改变返回箭头
    UIImage *backImage = [[UIImage imageNamed:@"icon_navi_back3"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   [UINavigationBar appearance].backIndicatorTransitionMaskImage = backImage;
    [UINavigationBar appearance].backIndicatorImage = backImage;
    
    //返回按钮文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-300, -0) forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - userdefault

/**
 *  保存用户设置
 */
void saveUserSetting(NSString *key, id value)
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}




/**
 *  获取用户设置
 */
id getSetting(NSString *key)
{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}


/**
 *  保存对象设置
 */
void saveObjectSetting(NSString *key, id value)
{
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:value];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

id getObjectSetting(NSString *key){
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return obj;
}


#pragma mark - 是否登录
/**
 *  是否登录
 *
 */

+ (BOOL) userIsLogin
{
    if ([getSetting(kIsLoginKey)integerValue] == 1) {
        return YES;
    }else{
        return NO;
    }
    
}

#pragma mark - 修正图片转向
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
    
}


#pragma mark - 解档 和 归档 用户的个人信息
////解档
//+(PCGUserInfoModel *)customUnKeyedArchiverZUserInfoModel{
//    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:kArchivingFilePath];
//    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    //获得类
//    PCGUserInfoModel *model = [unarchiver decodeObjectForKey:kArchivingDataKey];// initWithCoder方法被调用
//    [unarchiver finishDecoding];
//    return model;
//}




//+(void)customKeyedArchiverZUserInfoModel:(PCGUserInfoModel *)model{
//    //归档
//    NSMutableData *data = [[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//
//    [archiver encodeObject:model forKey:kArchivingDataKey]; // model的encodeWithCoder
//    //方法被调用
//    [archiver finishEncoding];
//    //写入文件
//    [data writeToFile:kArchivingFilePath atomically:YES];
//}

#pragma mark - 根据id来解析出省市区的name
+(NSString *)parseNameWithId:(NSString *)id{
    __block NSString *name = @"";
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"simple_cities_pro_city_dis" ofType:@"json"]];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    //省
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull provinceData, NSUInteger idx, BOOL * _Nonnull stop) {
        if([provinceData[@"id"] isEqualToString:id]){
            name = provinceData[@"name"];
        }
        //城市
        NSArray *citys = provinceData[@"cityList"];
        [citys enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull cityData, NSUInteger idx, BOOL * _Nonnull stop) {
            if([cityData[@"id"] isEqualToString:id]){
                name = cityData[@"name"];
            }
            //区
            NSArray *regions = cityData[@"cityList"];
            [regions enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull regionData, NSUInteger idx, BOOL * _Nonnull stop) {
                if([regionData[@"id"] isEqualToString:id]){
                    name = regionData[@"name"];
                }
            }];
        }];
    }];
    return name;
}

NSString *convertStampToDate(NSString *stamp){
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:[stamp floatValue]];
    NSString *date_str = [stampFormatter stringFromDate:stampDate];
    return date_str;
}




@end
