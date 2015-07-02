//
//  PhotosVC.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "PhotosVC.h"
#import "PhotoCollectionCell.h"
#import "LoaderCollectionCell.h"
#import "Page.h"
#import "ReloadButton.h"
#import "PagesCollection.h"



#import <AFNetworking.h>


#define CELL_IDENTIFIER @"cell"
#define CELL_LOADER_ID @"loader_cell"

#define NUMBER_OF_CELL_PER_ROW @3



@interface PhotosVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (retain, nonatomic) UICollectionView *collectionVPhotos;
@property (retain, nonatomic) ReloadButton *btnReload;
@property (assign, nonatomic) BOOL performingDataFetch;

@end

@implementation PhotosVC


-(void)loadView{
    
    [super loadView];
    
    
    self.performingDataFetch=NO;
    
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=self.view.frame.size.height;
    
    // Set background image
    [self setUpBgImage:[UIImage imageNamed:@"main-bg.jpg"] WithWidth:width Height:height];
    
    // Setup collectionView
    [self setUpCollectionViewWithWidth:width Height:height];
    
    // Set navigation title
    [self setNavigationTitle:[self appName]];
    
    // Fetch data from API
    [self reloadRequest];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}






#pragma mark Private functions and methods

-(void)setUpCollectionViewWithWidth:(CGFloat)width Height:(CGFloat)height{
    
    // Define the width for the cells containing the photos.
    CGFloat cellWidth=[[UIScreen mainScreen] bounds].size.width/3;
    
    // Set CollectionView layout
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    // Instantiate CollectionView
    self.collectionVPhotos=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:flowLayout];
    
    // Set CollectionView insets
    [self.collectionVPhotos setContentInset:UIEdgeInsetsMake(10.0, 0, 0, 0)];
    // Set clear background color to the CollectionView
    self.collectionVPhotos.backgroundColor=[UIColor clearColor];
    // Add CollectionView to superView.
    [self.view addSubview:self.collectionVPhotos];
    
    
    // Register cells and delegates
    [self.collectionVPhotos registerClass:[PhotoCollectionCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [self.collectionVPhotos registerClass:[LoaderCollectionCell class] forCellWithReuseIdentifier:CELL_LOADER_ID];
    self.collectionVPhotos.delegate=self;
    self.collectionVPhotos.dataSource=self;
}

-(void)fetchDataFromAPIForPage:(NSInteger)pageNum{
    
    // If a previous request has already been launched,
    // then it will exit the method.
    if (self.performingDataFetch) return;
    
    //
    
    // Otherwise, set the flag to indicate that
    // a request is in progress.
    self.performingDataFetch=YES;
    
    [[APIHandler sharedManager] getFlickrPhotoListWithPageNumber:pageNum Completion:^(Response * response){
        
        if (response.errorOccured)
            [self showAlertWithText:response.error];
        
        
        Page *page=(Page *)response.object;
        if (page != nil){
            [[PagesCollection sharedManager] addPage:page];
            [[PagesCollection sharedManager] setLastPageLoaded:pageNum];
        }
        
        
        [self.collectionVPhotos reloadData];
        
        
        // Dismiss loader
        [self showLoader:NO];
        
        
        // Set flag to NO, so future request can be launched.
        self.performingDataFetch=NO;
        
        
        // Show reload button in case the photos array is empty.
        if ([[PagesCollection sharedManager] numberOfPagesLoaded]==0)
            [self showRefreshButton:YES];
        
        else // Remove the reload button
            [self showRefreshButton:NO];
        
    }];
}

-(void)showRefreshButton:(BOOL)shouldAdd{
    
    if (shouldAdd) {
        
        if (self.btnReload==nil){
            
            CGFloat buttonSize=50.0;
            
            self.btnReload=[[ReloadButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize, buttonSize)];
            [self.btnReload addTarget:self action:@selector(reloadRequest) forControlEvents:UIControlEventTouchUpInside];
            [self.btnReload showWithAnimationInView:self.view];
            
        }
    }
    else{
        [self.btnReload removeWithAnimation:^{
            
            self.btnReload=nil;
        }];
    }
}

-(void)checkReachability{
    
    // If connection available
    if ([[AFNetworkReachabilityManager sharedManager] isReachable])
        [self fetchDataFromAPIForPage:[[PagesCollection sharedManager] lastPageLoaded]+1];
    
    else{ // If no connection available
        
        if ([[PagesCollection sharedManager] numberOfPagesLoaded]==0){//([self.pagesArr count]==0){
            
            [self showLoader:NO];
            [self showRefreshButton:YES];
        }
        
        [self showAlertWithText:NSLocalizedString(@"no_internet_connection", nil)];
    }
}






#pragma mark Actions

-(void)reloadRequest{
    
    // Check if previous retry was already made
    BOOL isRetry=NO;
    if (self.btnReload != nil){
        [self showRefreshButton:NO];
        isRetry=YES;
    }
    
    
    [self showLoader:YES];
    
    
    if (isRetry)
        [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(checkReachability) userInfo:nil repeats:NO];
    
    else{
        
        // Check wether there's a connection available
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
            
            [self checkReachability];
        }];
    }
}








#pragma mark UICollectionView delegate methods






#pragma mark Warnings

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
