//
//  TTViewController.m
//  UIWebViewContent
//
//  Created by Sergey Reshetnyak on 5/8/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTViewController.h"
#import "TTWebController.h"

@interface TTViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic) UITableView *tabelView;
@property (strong,nonatomic) NSArray *itemPDF;
@property (strong,nonatomic) NSArray *itemURL;

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    1. Сделайте один контроллер с таблицей, в ней две секции: pdf и url
//    2. Присоедините к проекту парочку pdf файлов, их имена должны быть в таблице
//    3. Добавьте парочку web сайтов во вторую секцию
//    4. Когда я нажимаю на ячейку, то через пуш навигейшн должен отобразиться либо пдф либо web
//    5. Надеюсь понятно что для загрузки того либо другого мы используем один и тот же контроллев с UIWebView и иницианизируем его нужным NSURL
//    6. На веб вью должна быть крутилка, а в навигейшине кнопки назад и вперед
    
    CGRect rect = self.view.bounds;
    rect.origin = CGPointZero;
    
    UITableView *tabelView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    tabelView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    tabelView.dataSource = self;
    tabelView.delegate = self;
    tabelView.separatorInset = UIEdgeInsetsZero;
    
    [self.view addSubview:tabelView];
    self.tabelView = tabelView;
    
    NSArray *tempPDF = @[@"1.pdf",@"2.pdf"];
    NSArray *tempURL = @[@"https://github.com/sreshetnyak",@"http://habrahabr.ru/",@"http://www.apple.com/"];
    self.itemPDF = tempPDF;
    self.itemURL = tempURL;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

- (NSString *)urlForFile:(NSString *)file {

   return [[NSBundle mainBundle] pathForResource:file ofType:nil];
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return @"pdf";
        
    } else if (section == 1) {
        
        return @"url";
    } else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return [self.itemPDF count];
        
    } else if (section == 1) {
        
        return [self.itemURL count];
    } else {
    
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = [self.itemPDF objectAtIndex:indexPath.row];
        
    } else if (indexPath.section == 1) {
        
        cell.textLabel.text = [self.itemURL objectAtIndex:indexPath.row];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        TTWebController *vc = [[TTWebController alloc]init];
        
        
        vc.dataURL = [NSURL fileURLWithPath:[self urlForFile:[self.itemPDF objectAtIndex:indexPath.row]]];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.section == 1) {
        
        TTWebController *vc = [[TTWebController alloc]init];
        
        vc.dataURL = [NSURL URLWithString:[self.itemURL objectAtIndex:indexPath.row]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
