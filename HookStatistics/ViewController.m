//
//  ViewController.m
//  HookStatistics
//
//  Created by wpstarnice on 2016/12/23.
//  Copyright © 2016年 yd. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()<CustomViewDelegate>

@property(nonatomic,strong)CustomView *customView;
@property(nonatomic,strong)UIButton *protocolBtn;
@property(nonatomic,strong)UIButton *blockBtn;
@property(nonatomic,strong)UIButton *normalBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.protocolBtn];
    [self.view addSubview:self.blockBtn];
    [self.view addSubview:self.normalBtn];
    [self.view addSubview:self.customView];
    
    [self privateInstanceMethod];
    [ViewController privateClassMethod];
}

#pragma mark - CustomViewDelegate

-(void)someDelegateTriggerWithArg:(UIColor *)color{

    NSLog(@"delegate method:%s",__func__);
    self.customView.backgroundColor = color;
}

#pragma mark - private

+(void)privateClassMethod{
    
    NSLog(@"method:%s", __func__);
}

-(void)privateInstanceMethod{

    NSLog(@"method:%s", __func__);
}

-(void)clickTestNormal{
    
    NSLog(@"method:%s", __func__);
}

-(void)clickTestProtocol{

    [self.customView doSomething];

}

-(void)clickTestBlock{
    
    [self clickTestBlockCompletion:^(NSString *text) {
        
        NSLog(@"block method:%@",text);
        //if need statistic arg in block
    }];
}

#pragma mark block

-(void)clickTestBlockCompletion:(ClickCompletion)block{
    
    if (block) {
        
        block(NSStringFromSelector(_cmd));
    }
}

#pragma mark - getter

-(UIButton *)normalBtn{
    
    if (nil == _normalBtn) {
        
        _normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_normalBtn setFrame:CGRectMake(100, 50, 150, 50)];
        [_normalBtn setTitle:@"testNormalClick" forState:UIControlStateNormal];
        [_normalBtn setBackgroundColor:[UIColor blueColor]];
        [_normalBtn addTarget:self action:@selector(clickTestNormal) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _normalBtn;
}

-(UIButton *)protocolBtn{

    if (nil == _protocolBtn) {
        
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocolBtn setFrame:CGRectMake(100, 150, 150, 50)];
        [_protocolBtn setTitle:@"testprotocol" forState:UIControlStateNormal];
        [_protocolBtn setBackgroundColor:[UIColor redColor]];
        [_protocolBtn addTarget:self action:@selector(clickTestProtocol) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _protocolBtn;
}

-(UIButton *)blockBtn{
    
    if (nil == _blockBtn) {
        
        _blockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_blockBtn setFrame:CGRectMake(100, 250, 150, 50)];
        [_blockBtn setTitle:@"testblock" forState:UIControlStateNormal];
        [_blockBtn setBackgroundColor:[UIColor purpleColor]];
        [_blockBtn addTarget:self action:@selector(clickTestBlock) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _blockBtn;
}

-(CustomView *)customView{

    if (nil == _customView) {
        
        _customView = [[CustomView alloc]initWithFrame:CGRectMake(50, 350, 200, 100)];
        _customView.backgroundColor = [UIColor orangeColor];
        _customView.delegate = self;
    }

    return _customView;
}

@end
