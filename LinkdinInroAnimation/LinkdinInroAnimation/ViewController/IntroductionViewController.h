//
//  IntroductionViewController.h
//  Buddisout
//
//  Created by Pragnesh Dixit on 10/3/15.
//  Copyright (c) 2015 Tristate Team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;


@interface IntroductionViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionIntroduction;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat lastContentOffset;

@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSMutableArray *arrImages;
@property (nonatomic, strong) NSMutableArray *arrIntrotext;

@property (nonatomic) int currentpage;

@property (strong, nonatomic) IBOutlet UIImageView *img_introimages;
@property (strong, nonatomic) IBOutlet UIImageView *imgHightlightImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tralingSpaceofIntroimage;

@property (nonatomic) BOOL isStop;

- (IBAction)pageControlAction:(id)sender;
@end
