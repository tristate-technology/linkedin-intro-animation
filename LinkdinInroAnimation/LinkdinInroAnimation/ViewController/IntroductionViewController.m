//
//  IntroductionViewController.m
//  Buddisout
//
//  Created by Pragnesh Dixit on 10/3/15.
//  Copyright (c) 2015 Tristate Team. All rights reserved.
//

#import "IntroductionViewController.h"
#import "IntroductionCell.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController
@synthesize imgHightlightImage;


#pragma -mark view life cycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.arrImages=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];

    self.arrIntrotext=[[NSMutableArray alloc] initWithObjects:@"Sample text for Page 1",@"Sample text for Page 2",@"Sample text for Page 3",@"Sample text for Page 4", nil];
  
    [self setupCollectionView];
    [self rightanimatetoImage];
    self.img_introimages.image=[UIImage imageNamed:[self.arrImages objectAtIndex:0]];
    self.imgHightlightImage.image = [UIImage imageNamed:[self.arrImages objectAtIndex:0]];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}

-(void)rightanimatetoImage {
    
    self.img_introimages.frame = CGRectMake(-80,0,self.img_introimages.frame.size.width, self.img_introimages.frame.size.height);
    self.imgHightlightImage.frame =  CGRectMake(-80,0,self.imgHightlightImage.frame.size.width , self.imgHightlightImage.frame.size.height);
    
    [self.img_introimages.class animateWithDuration:10.0 delay:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.img_introimages.frame = CGRectMake(0,0,self.img_introimages.frame.size.width , self.img_introimages.frame.size.height);
        self.imgHightlightImage.frame =  CGRectMake(0,0,self.imgHightlightImage.frame.size.width , self.imgHightlightImage.frame.size.height);
        
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self leftanimatetoImage];
        }
        //
    }];
}
-(void)leftanimatetoImage{
    self.isStop = NO;
    [self.img_introimages.class animateWithDuration:10.0 delay:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.img_introimages.frame = CGRectMake(-80,0,self.img_introimages.frame.size.width, self.img_introimages.frame.size.height);
        self.imgHightlightImage.frame =  CGRectMake(-80,0,self.imgHightlightImage.frame.size.width , self.imgHightlightImage.frame.size.height);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self rightanimatetoImage];
        }
        // [self rightanimatetoImage];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma -mark collectonViewSetup

-(void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self.collectionIntroduction setPagingEnabled:YES];
    [self.collectionIntroduction setCollectionViewLayout:flowLayout];
}
-(void)scrollToSelectedPage:(NSInteger)index
{
    self.collectionIntroduction.hidden=NO;
    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionIntroduction scrollToItemAtIndexPath:indexPath
                                        atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
}


#pragma - mark collectionview Datasource and Delegate

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arrImages count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    IntroductionCell *introCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IntroductionCell" forIndexPath:indexPath];
    
    introCell.lblIntroduction.text=[NSString stringWithFormat:@"%@",[self.arrIntrotext objectAtIndex:indexPath.row]];

    return introCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionIntroduction.frame.size;
}
#pragma - mark Scrollview Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   self.lastContentOffset = scrollView.contentOffset.x;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/self.view.bounds.size.width;
    
    self.img_introimages.image=[UIImage imageNamed:[self.arrImages objectAtIndex:page]];
    
    
    
    ScrollDirection scrollDirection;
    if (self.lastContentOffset > scrollView.contentOffset.x)
        scrollDirection = ScrollDirectionRight;
    else if (self.lastContentOffset < scrollView.contentOffset.x)
        scrollDirection = ScrollDirectionLeft;
    
    BOOL isAnimation = false;
    if (scrollDirection == ScrollDirectionRight) {
     

        if (page<3) {
            if (self.pageControl.currentPage == 0) {
                isAnimation = true;
                self.imgHightlightImage.image=[UIImage imageNamed:[self.arrImages objectAtIndex:page+1]];
            }
            else{
                isAnimation = true;
                 self.imgHightlightImage.image=[UIImage imageNamed:[self.arrImages objectAtIndex:page+1]];
            }
           
        }
    }
    else{
        if (self.pageControl.currentPage == 3) {
            isAnimation = false;
            self.imgHightlightImage.image=[UIImage imageNamed:[self.arrImages objectAtIndex:3]];
        }
        else{
            isAnimation = true;
            self.imgHightlightImage.image=[UIImage imageNamed:[self.arrImages objectAtIndex:self.pageControl.currentPage+1]];
        }
    }

    
    if (isAnimation) {
        [UIView animateWithDuration:2.0f animations:^{
            [self.imgHightlightImage setAlpha:0.7f];
            [self.img_introimages setAlpha:0.7f];
            
        } completion:^(BOOL finished) {
            
            //fade out
            [UIView animateWithDuration:2.0f animations:^{
                [self.imgHightlightImage setAlpha:0.0f];
                [self.img_introimages setAlpha:1.0f];
            } completion:nil];
            
        }];
    }
    self.pageControl.currentPage = page;

    [self.img_introimages.layer removeAllAnimations];
     [self.imgHightlightImage.layer removeAllAnimations];
    self.img_introimages.frame = CGRectMake(0,0,self.view.frame.size.width +80, self.img_introimages.frame.size.height);
    self.imgHightlightImage.frame = CGRectMake(0, 0, self.view.frame.size.width +80, self.imgHightlightImage.frame.size.height);

    [self.img_introimages.layer removeAllAnimations];

    self.img_introimages.frame = CGRectMake(0,0,self.view.frame.size.width +80, self.img_introimages.frame.size.height);
    
    [self rightanimatetoImage];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
- (void)changePage:(UIPageViewControllerNavigationDirection)direction {
    
}
#pragma - mark UIButton  Action
- (IBAction)pageControlAction:(id)sender {
    
    UIPageControl *pagecontrol = sender;
    [self scrollToSelectedPage:pagecontrol.currentPage];
}



@end
