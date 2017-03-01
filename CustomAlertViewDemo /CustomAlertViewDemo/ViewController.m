//
//  ViewController.m
//  CustomAlertViewDemo
//
//  Created by tan on 2016/11/8.
//  Copyright © 2016年 tantan. All rights reserved.
//

#import "ViewController.h"
#import "ECGCustomAlertView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray * arrTitle;
}
@property (weak ,nonatomic) IBOutlet UITableView *tableView;
@property(strong ,nonatomic) ECGCustomAlertView *alertView;

@end

static NSString *cellId = @"cell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    arrTitle = @[@"底部两个button效果", @"底部单个button效果", @"无标题效果", @"底部button样式修改", @"多个button效果", @"自定义弹出视图", @"有标题自定义输入框视图",@"无标题自定义输入框视图"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellId];
    }
    cell.detailTextLabel.text = arrTitle[indexPath.row];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showAlertView:indexPath.row];
}

-(void)showAlertView:(NSInteger)row
{
    switch (row) {
        case 0:
        {
            [ECGCustomAlertView showTwoButtonsWithTitle:@"提示信息" Message:@"这里为提示的信息内容，里面会根据内容的高度进行计算，当大于弹出窗默认的高度时会自行适应高度(并自动转成UITextView来加载内容)" ButtonType:ECGAlertViewButtonTypeNone ButtonTitle:@"取消" Click:^{
                NSLog(@"您点取消事件");
            } ButtonType:ECGAlertViewButtonTypeNone ButtonTitle:@"确定" Click:^{
                NSLog(@"你点确定事件");
            }];
            break;
        }
        case 1:
        {
            [ECGCustomAlertView showOneButtonWithTitle:@"信息提示" Message:@"你可以单独设置底部每个Button的样式，只要相应枚举进行调整，若不满足可以对针WJYAlertView源代码进行修改，增加相应的枚举类型及其代码" ButtonType:ECGAlertViewButtonTypeNone ButtonTitle:@"知道了" Click:^{
                NSLog(@"响应事件");
            }];
            break;
        }
        case 2:
        {
            [ECGCustomAlertView showOneButtonWithTitle:nil Message:@"你可以把Title设置为nil" ButtonType:ECGAlertViewButtonTypeNone ButtonTitle:@"知道了" Click:^{
                NSLog(@"响应事件");
            }];
            break;
        }
        case 3:
        {
            [ECGCustomAlertView showTwoButtonsWithTitle:@"提示信息" Message:@"你可以设置ButtonType的样式来调整效果，而且还可以分开设置，更加灵活，不效果项目要求可以修改源代码" ButtonType:ECGAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:^{
                NSLog(@"您点取消事件");
            } ButtonType:ECGAlertViewButtonTypeDefault ButtonTitle:@"确定" Click:^{
                NSLog(@"你点确定事件");
            }];
            break;
        }
        case 4:
        {
            [ECGCustomAlertView showMultipleButtonsWithTitle:@"信息内容" Message:@"可以设置多个的Button,同样也是可以有不同的样式效果" Click:^(NSInteger index) {
                NSLog(@"你点击第几个%zi", index);
            } Buttons:@{@(ECGAlertViewButtonTypeDefault):@"确定"},@{@(ECGAlertViewButtonTypeCancel):@"取消"},@{@(ECGAlertViewButtonTypeWarn):@"知道了"}, nil];
            break;
        }
        case 5:
        {
            //自定义视图
            UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 200)];
            customView.backgroundColor = [UIColor blueColor];
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
            [btn setTitle:@"点我关闭" forState:UIControlStateNormal];
            btn.center = CGPointMake(120, 100);
            [customView addSubview:btn];
            [btn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            // dismissWhenTouchedBackground:NO表示背景蒙层没有关闭弹出窗效果
            _alertView = [[ECGCustomAlertView alloc] initWithCustomView:customView dismissWhenTouchedBackground:NO];
            [_alertView show];
            break;
        }
        case 6:
        {
            [ECGCustomAlertView showContainsTextViewWithTitle:@"消息内容" leftButtonTitle:@"取消"  rightButtonTitle:@"确定"  placeholderText:@"请输入正确的订单号" tipLabelTitle:150 click:^(int index, NSString *content) {
                NSLog(@"点击的是index为%d内容为%@",index,content);
            }];

            break;
        }
        case 7:
        {
            [ECGCustomAlertView showContainsTextViewWithTitle:nil leftButtonTitle:@"取消"  rightButtonTitle:@"确定"  placeholderText:@"请输入正确的订单号" tipLabelTitle:200 click:^(int index, NSString *content) {
                NSLog(@"点击的是index为%d内容为%@",index,content);
            }];
            
            break;
        }
        default:
            break;
    }
}

-(void)closeBtnClick
{
    // 如果没有其它事件要处理可以直接用下面这样关闭
    // [_alert dismissWithCompletion:nil];
    
    [_alertView dismissWithCompletion:^{
        // 处理内容
        NSLog(@"弹出窗被关闭了");
    }];
}


@end
