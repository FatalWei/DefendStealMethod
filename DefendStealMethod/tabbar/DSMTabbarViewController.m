//
//  PCGTabbarViewController.m
//  PregnantClothesGroup
//
//  Created by 张才维 on 2018/1/15.
//  Copyright © 2018年 zcw. All rights reserved.
//

#import "DSMTabbarViewController.h"

#import "DMFMainViewController.h"
#import "DMFMineViewController.h"

#import "TransitionAnimation.h"
#import "TransitionController.h"


#define kViewController        @"viewController"
#define kTitle                  @"title"
#define kTabbarItemNormalImage      @"itemNormalImage"
#define kTabbarItemSelectedImage    @"itemSelectedImage"

@interface DSMTabbarViewController ()<UITabBarControllerDelegate>
@property(nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation DSMTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupChindControllers];
    
    
    
    
    
}










#pragma mark - setupChildControllers

-(void)setupChindControllers{
    
    NSArray *viewControllers = @[
                                 @{
                                     kViewController:[[DMFMainViewController alloc]init],
                                     kTitle:@"首页",
                                     kTabbarItemNormalImage:@"shouye_w",
                                     kTabbarItemSelectedImage:@"shouye_x"
                                     },
                                 
                                 @{
                                     kViewController:[[DMFMineViewController alloc]init],
                                     kTitle:@"我的",
                                     kTabbarItemNormalImage:@"xuanyi_w",
                                     kTabbarItemSelectedImage:@"xuanyi_x"
                                     },
                                 
                    
                                 ];
    
    
    // 添加子控制器
    [viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildVc:obj[kViewController]
                   title:obj[kTitle]
                   image:obj[kTabbarItemNormalImage]
           selectedImage:obj[kTabbarItemSelectedImage]];
    }];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : colorWithHexString(@"959595")} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : TEXT_COLOR_333333} forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
    // 为子控制器包装导航控制器
    UINavigationController *navigationVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];
    //  self setViewControllers:<#(NSArray<__kindof UIViewController *> * _Nullable)#> animated:<#(BOOL)#>
}



- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    // 打开注释 可以屏蔽点击item时的动画效果
    //    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    NSArray *viewControllers = tabBarController.viewControllers;
    if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
        return [[TransitionAnimation alloc] initWithTargetEdge:UIRectEdgeLeft];
    }
    else {
        return [[TransitionAnimation alloc] initWithTargetEdge:UIRectEdgeRight];
    }
    //    }
    //    else{
    //        return nil;
    //    }
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    //    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
    //        return [[TransitionController alloc] initWithGestureRecognizer:self.panGestureRecognizer];
    //    }
    //    else {
    //        return nil;
    //    }
    return nil;
}






@end

