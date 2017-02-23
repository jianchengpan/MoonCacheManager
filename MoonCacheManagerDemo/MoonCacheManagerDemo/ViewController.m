//
//  ViewController.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "ViewController.h"

#import "StudentModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    StudentModel *student = [StudentModel new];
    student.sID = @"12";
    student.name = @"Davi";
    student.age = 21;
    student.ignoreProperties = @"ignoreProperties";
    
    [MoonCacheManager saveWithSqlMaker:^(MoonSqlSaveMaker *maker) {
        maker.save(student);
    } andError:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
