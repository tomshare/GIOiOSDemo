//
//  HomeController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/4.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "HomeController.h"
#import "HomeCell.h"
#import "GoodsDetailController.h"
#import "LoopView.h"
#import "SearchViewController.h"
#import "OrderController.h"
@interface HomeController ()
@property(nonatomic , strong)  UIScrollView *backScrollView ;
@property(nonatomic , strong)  UIView *bannerView ;
@property(nonatomic , strong)  UIView *upView ;
@property(nonatomic , strong)  UIView *backSeckillingView ;
@property(nonatomic , strong)  UIView *recommendView ;
@property(nonatomic , strong)  UIView *bestSaleView ;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height + 300) ;
    [self.view addSubview:self.backScrollView];
    
    [self makeBanner];
    [self makeUpview];
    [self makeSeckillingView];
    [self makeRecommendView];
}

-(void)makeBanner{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 0,220, 20)];
    [btn setTitle:@"GIO 马克杯" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,120)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imaview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imaview.image = [UIImage imageNamed:@"搜索"];
    [view addSubview:imaview];
    [view addSubview:btn];
    self.navigationItem.titleView = view ;
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@"11",@"12",@"13", nil] ;
    self.bannerView = [[LoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width ,220) andImageArray:mutableArray];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.bannerView addGestureRecognizer:tapGesturRecognizer];
    [self.backScrollView addSubview:self.bannerView];
}

-(void)btnClick{
    SearchViewController *VC = [[SearchViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC  animated:NO];
}

-(void)makeUpview{
    self.upView =[[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.bannerView.frame) + 40 , self.view.bounds.size.width - 40, 120)];
    for (int i = 0; i < 4; i ++) {
        HomeCell *cell = [[HomeCell alloc] initWithFrame:CGRectMake(i *  (self.view.bounds.size.width - 40)/4.0 ,0, (self.view.bounds.size.width - 40)/4.0 , 120)];
        cell.width = 40 ;
        cell.height = 40 ;
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]] ;
        cell.titleLabel.textAlignment = NSTextAlignmentCenter ;
        
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2:)];
    
        [cell addGestureRecognizer:tapGesturRecognizer];
        
        switch (i) {
            case 0:
                {
                    cell.titleLabel.text  = @"商品分类" ;
                    tapGesturRecognizer.view.tag = i ;
                }
                break;
            case 1:
            {
                 cell.titleLabel.text  = @"精品推荐" ;
                tapGesturRecognizer.view.tag = i ;
            }
                break;
            case 2:
            {
                 cell.titleLabel.text  = @"购物车" ;
                tapGesturRecognizer.view.tag = i ;
            }
                break;
            case 3:
            {
                 cell.titleLabel.text  = @"查看订单" ;
                tapGesturRecognizer.view.tag = i ;
            }
                break;
            default:
                break;
        }

        
        UIView *divideView = [[UIView alloc] initWithFrame:CGRectMake(-20, self.upView.frame.size.height, self.view.frame.size.width, 0.5)];
        divideView.backgroundColor = [UIColor lightGrayColor];
        [self.upView addSubview:divideView];
        [self.upView addSubview:cell];
    }
    [self.backScrollView addSubview:self.upView];
}

-(void)tapAction2:(id)sender{
      UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
      UIView *views = (UIView*) tap.view;
      NSUInteger tag = views.tag;
      switch (tag) {
        case 0:
            {
                self.tabBarController.selectedIndex = 1 ;
            }
            break;
        case 1:
          {
              self.tabBarController.selectedIndex = 1 ;
          }
              break;
        case 2:
          {
              self.tabBarController.selectedIndex = 2 ;
          }
              break;
        case 3:
          {
              OrderController *VC = [[OrderController alloc] init];
              VC.hidesBottomBarWhenPushed = YES ;
              [self.navigationController pushViewController:VC animated:NO];
          }
              break;
        default:
            break;
    }
}

-(void)tapAction
{
    GoodsDetailController *VC = [[GoodsDetailController alloc] init];
    VC.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)makeSeckillingView{
    self.backSeckillingView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.upView.frame) + 10, self.view.bounds.size.width - 40, 220)];
    UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , self.view.bounds.size.width - 40, 30)];
    upLabel.textAlignment = NSTextAlignmentLeft ;
    upLabel.textColor = [UIColor blackColor];
    upLabel.text = @"限时秒杀" ;
    [self.backSeckillingView addSubview:upLabel];
    
    self.backSeckillingView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 3; i ++) {
        HomeCell *cell = [[HomeCell alloc] initWithFrame:CGRectMake(10 * i +  i *  (self.view.bounds.size.width - 40 - 40)/3.0 + 20 ,40, (self.view.bounds.size.width - 40 - 40)/3.0 , 200 - 40 - 20 )];
        cell.width  = cell.bounds.size.width ;
        cell.height = cell.bounds.size.height ;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [cell addGestureRecognizer:tapGesturRecognizer];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"book%d",i+1]] ;
        cell.titleLabel.textAlignment = NSTextAlignmentCenter ;
        [self.backSeckillingView addSubview:cell];
    }
    [self.backScrollView addSubview:self.backSeckillingView];
}

-(void)makeRecommendView{
    self.recommendView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.backSeckillingView.frame), self.view.bounds.size.width - 40, 200)];
    UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , self.view.bounds.size.width - 40, 30)];
    upLabel.textAlignment = NSTextAlignmentLeft ;
    upLabel.text = @"GIO推荐" ;
    [self.recommendView addSubview:upLabel];
    self.recommendView.backgroundColor = [UIColor whiteColor];
   HomeCell *cell = [[HomeCell alloc] initWithFrame:CGRectMake(0,40, (self.view.bounds.size.width - 40) , 200 - 40 - 20 )];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [cell addGestureRecognizer:tapGesturRecognizer];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"suggest"]] ;
    cell.width  = cell.bounds.size.width ;
    cell.height = cell.bounds.size.height ;
    [self.recommendView addSubview:cell];
    [self.backScrollView addSubview:self.recommendView];
}

@end