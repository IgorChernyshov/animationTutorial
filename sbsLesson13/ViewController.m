//
//  ViewController.m
//  sbsLesson13
//
//  Created by Igor Chernyshov on 05/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "ViewController.h"

static CGFloat photoSize = 150.f;

@interface ViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIView *photoBorderView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self createUI];
}


#pragma mark - Configure UI

- (void)createUI
{
	[self createHeaderView];
	[self createPhotoBorderView];
	[self createPhotoImageView];
	[self createTableView];
	[self createButton];
	
	[self setupConstraints];
}

- (void)createHeaderView
{
	self.headerView = [UIView new];
	self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
	self.headerView.backgroundColor = [UIColor lightGrayColor];
	
	[self.view addSubview:self.headerView];
}

- (void)createPhotoImageView
{
	self.photoImageView = [UIImageView new];
	self.photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
	self.photoImageView.clipsToBounds = YES;
	self.photoImageView.layer.cornerRadius = photoSize / 2.f;
	self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
	self.photoImageView.image = [UIImage imageNamed:@"photo"];
	
	[self.headerView addSubview:self.photoImageView];
}

- (void)createPhotoBorderView
{
	self.photoBorderView = [UIView new];
	self.photoBorderView.translatesAutoresizingMaskIntoConstraints = NO;
	self.photoBorderView.clipsToBounds = YES;
	self.photoBorderView.layer.cornerRadius = (photoSize * 1.05) / 2.f;
	self.photoBorderView.backgroundColor = [UIColor darkGrayColor];
	self.photoBorderView.alpha = 0.4;
	
	[self.headerView addSubview:self.photoBorderView];
}

- (void)createTableView
{
	self.bottomView = [UIView new];
	self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.view addSubview:self.bottomView];
}

- (void)createButton
{
	self.button = [UIButton buttonWithType:UIButtonTypeSystem];
	self.button.translatesAutoresizingMaskIntoConstraints = NO;
	self.button.backgroundColor = [UIColor blueColor];
	[self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.button setTitle:@"PUSH ME" forState:UIControlStateNormal];
	[self.button addTarget:self action:@selector(buttonWasTapped) forControlEvents:UIControlEventTouchUpInside];
	
	[self.bottomView addSubview:self.button];
}

- (void)setupConstraints
{
	NSArray<NSLayoutConstraint *> *constraints =
	@[
	  [self.headerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
	  [self.headerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
	  [self.headerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
	  [self.headerView.heightAnchor constraintEqualToConstant:CGRectGetMidY(self.view.frame)],
	  
	  [self.photoBorderView.centerXAnchor constraintEqualToAnchor:self.headerView.centerXAnchor],
	  [self.photoBorderView.centerYAnchor constraintEqualToAnchor:self.headerView.centerYAnchor],
	  [self.photoBorderView.heightAnchor constraintEqualToConstant:photoSize * 1.05],
	  [self.photoBorderView.widthAnchor constraintEqualToConstant:photoSize * 1.05],
	  
	  [self.photoImageView.centerXAnchor constraintEqualToAnchor:self.headerView.centerXAnchor],
	  [self.photoImageView.centerYAnchor constraintEqualToAnchor:self.headerView.centerYAnchor],
	  [self.photoImageView.heightAnchor constraintEqualToConstant:photoSize],
	  [self.photoImageView.widthAnchor constraintEqualToConstant:photoSize],
	  
	  [self.bottomView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
	  [self.bottomView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
	  [self.bottomView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
	  [self.bottomView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
	  
	  [self.button.centerXAnchor constraintEqualToAnchor:self.bottomView.centerXAnchor],
	  [self.button.centerYAnchor constraintEqualToAnchor:self.bottomView.centerYAnchor],
	  [self.button.heightAnchor constraintEqualToConstant:50.f],
	  [self.button.widthAnchor constraintEqualToConstant:200.f]
	  ];
	
	[NSLayoutConstraint activateConstraints:constraints];
}


#pragma mark - Button's methods

-(void)buttonWasTapped
{
	[UIView animateWithDuration:0.5 animations:^{
		CGAffineTransform transform = self.photoImageView.transform;
		transform = CGAffineTransformRotate(transform, M_PI);
		self.photoImageView.transform = transform;
	}];
	
	CABasicAnimation *pulsatingBorderAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	pulsatingBorderAnimation.autoreverses = YES;
	pulsatingBorderAnimation.duration = 0.8;
	pulsatingBorderAnimation.repeatCount = INFINITY;
	pulsatingBorderAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	pulsatingBorderAnimation.fillMode = kCAFillModeForwards;
	pulsatingBorderAnimation.fromValue = @(1.f);
	pulsatingBorderAnimation.toValue = @(1.2);

	[self.photoBorderView.layer addAnimation:pulsatingBorderAnimation forKey:@"pulsatingAnimation"];
}

@end
