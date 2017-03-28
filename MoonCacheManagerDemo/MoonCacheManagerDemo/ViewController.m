//
//  ViewController.m
//  MoonCacheManagerDemo
//
//  Created by jianchengpan on 2017/1/18.
//  Copyright © 2017年 jianchengpan. All rights reserved.
//

#import "ViewController.h"

#import "StudentModel.h"
#import "ClassModel.h"

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

//    [MoonCacheManager deleteWithSqlMaker:^(MoonSqlDeleteMaker *maker) {
//        maker.deleteClass([StudentModel class]);
//    } andError:nil];
    [MoonCacheManager saveWithSqlMaker:^(MoonSqlSaveMaker *maker) {
        maker.save(student);
    } andError:nil];

    student.sID = @"18";
    student.name = @"Dfasi";
    student.age = 23;
    
    [MoonCacheManager saveWithSqlMaker:^(MoonSqlSaveMaker *maker) {
        maker.save(student);
    } andError:nil];
    
    NSArray *result = [MoonCacheManager queryWithSqlMaker:^(MoonSqlQueryMaker *maker) {
        maker.query([StudentModel class]).orderBy(@"age",MoonSqlMakerOrderTypeDESC).limit(1,10);
    } andError:nil];
    
    ClassModel *classModel = [ClassModel new];
    classModel.CId = @"qwer";
    classModel.CName = @"test class";
    
    [MoonCacheManager saveWithSqlMaker:^(MoonSqlSaveMaker *maker) {
        maker.save(classModel).with.relationObj(student);
    } andError:nil];
    
    NSLog(@"%@",result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
