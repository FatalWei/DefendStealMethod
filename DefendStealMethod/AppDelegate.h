//
//  AppDelegate.h
//  DefendStealMethod
//
//  Created by 张才维 on 2018/6/28.
//  Copyright © 2018年 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

