//
//  ViewController.h
//  Alcolator
//
//  Created by Larry Lynn on 12/2/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;

@property (weak, nonatomic) UISlider *beerCountSlider;

@property (weak, nonatomic) UILabel *resultLabel;

- (void)buttonPressed:(UIButton *)sender;

- (void)sliderValueDidChange:(UISlider *)sender;



@end

