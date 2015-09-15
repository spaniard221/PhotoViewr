//
//  PhotosVC.m
//  PhotoViewr
//
//  Created by Alex on 28/06/15.
//  Copyright (c) 2015 Alex Villamizar. All rights reserved.
//

#import "PhotosVC.h"
#import "PhotoDetailVC.h"
#import "PhotoCollectionCell.h"
#import "LoaderCollectionCell.h"
#import "PagesCollection.h"
#import "Page.h"
#import "ReloadButton.h"
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



#pragma mark - View methods

-(void)loadView{
    
    [super loadView];
    
    
    self.performingDataFetch=NO;
    
    
    CGFloat width=self.view.frame.size.width;
    CGFloat height=self.view.frame.size.height;
    
    
    self.title=[self appName];
    
    
    // Set background image
    [self setUpBgImage:[UIImage imageNamed:@"main-bg.jpg"] WithWidth:width Height:height];
    
    // Setup collectionView
    [self setUpCollectionViewWithWidth:width Height:height];
    
    // Fetch data from API
    [self reloadRequest];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}






#pragma mark - Private functions and methods

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
            [PagesCollection sharedManager].lastPageLoaded=pageNum;
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

-(void)checkIfInternetConnectionIsAvailable{
    
    // If connection available
    if ([AFNetworkReachabilityManager sharedManager].isReachable)
        [self fetchDataFromAPIForPage:[PagesCollection sharedManager].lastPageLoaded +1 ];
    
    else{ // If no connection available
        
        if ([PagesCollection sharedManager].numberOfPagesLoaded==0){
            
            [self showLoader:NO];
            [self showRefreshButton:YES];
        }
        
        [self showAlertWithText:NSLocalizedString(@"no_internet_connection", nil)];
    }
}






#pragma mark - Actions

-(void)reloadRequest{
    
    // Check if previous retry was already made
    BOOL isRetry=NO;
    if (self.btnReload != nil){
        [self showRefreshButton:NO];
        isRetry=YES;
    }
    
    
    [self showLoader:YES];
    
    
    if (isRetry)
        [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(checkIfInternetConnectionIsAvailable) userInfo:nil repeats:NO];
    
    else{
        
        // Check wether there's a connection available
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
            
            [self checkIfInternetConnectionIsAvailable];
        }];
    }
}








#pragma mark - UICollectionView delegate methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    // Load 2 sections, 0=Photo cells, 1=Loader cell
    NSInteger sections=[[PagesCollection sharedManager] numberOfPagesLoaded]+1;
    
    return sections;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    // Loader cell
    if (section==[[PagesCollection sharedManager] numberOfPagesLoaded])
        return 1;
    
    // Photo cell
    Page *page=[[PagesCollection sharedManager] pageAtIndex:section];
    return page.photoCount;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Loader cell
    if (indexPath.section==[[PagesCollection sharedManager] numberOfPagesLoaded])
        return CGSizeMake(collectionView.frame.size.width, 60);
    
    
    // Photo cells
    NSNumber *numCells=NUMBER_OF_CELL_PER_ROW;
    CGFloat width=[[UIScreen mainScreen] bounds].size.width/[numCells integerValue];
    return CGSizeMake(width, width);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==[[PagesCollection sharedManager] numberOfPagesLoaded]){
        
        LoaderCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CELL_LOADER_ID forIndexPath:indexPath];
        [cell setUpUI];
        
        
        // If the number of pages +1 have not been exceeded, then
        // fetch data from the next page
        if ([[PagesCollection sharedManager] canRequestMorePagesFromAPI])
            [self fetchDataFromAPIForPage:[PagesCollection sharedManager].lastPageLoaded + 1];
        
        else // Hide loader to imply that are no more items to load
            [cell.loader stopAnimating];
        
        
        return cell;
    }
    else{
        
        
        // Get cell
        PhotoCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                            forIndexPath:indexPath];
        
        cell.backgroundColor=[UIColor clearColor];
        cell.imgVPhoto.hidden=YES;
        
        // Set all the cell's views
        [cell setUI];
        
        // Get current photo
        Page *page=[[PagesCollection sharedManager] pageAtIndex:indexPath.section];
        if (page != nil){
            
            if (indexPath.row < page.photos.count){
                
                Photo *photo=page.photos[indexPath.row];
                
                // Get image from URL
                cell.imgVPhoto.hidden=NO;
                [cell.imgVPhoto sd_setImageWithURL:[NSURL URLWithString:[APIHandler photoURL:photo isThumbnail:YES]]];
            }
        }
        
        
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // If the section corresponds with the photo section
    if (indexPath.section < [[PagesCollection sharedManager] numberOfPagesLoaded]){
        
        PhotoCollectionCell *cell= (PhotoCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        // Get selected photo
        Page *page=[[PagesCollection sharedManager] pageAtIndex:indexPath.section];
        if (indexPath.row < page.photos.count){
            
            
            Photo *photo=page.photos[indexPath.row];
            
            // Instantiate the detail viewcontroller
            PhotoDetailVC *photoDetailVC=[[PhotoDetailVC alloc] initWithPhoto:photo Image:cell.imgVPhoto.image];
            
            // Animate cell selection
            [UIView animateWithDuration:0.3 animations:^{
                
                cell.imgVPhoto.alpha=0.7;
                
            }completion:^(BOOL finished){
                
                [UIView animateWithDuration:0.3 animations:^{
                    

                    cell.imgVPhoto.alpha=1.0;
                    
                }completion:^(BOOL finished){
                    
                    // When animation has concluded, then push the viewcontroller
                    if (finished){
                        
                        [self.navigationController pushViewController:photoDetailVC animated:YES];
                        
                    }
                }];
            }];
        }
        else
            [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    for (UICollectionViewCell *cell in self.collectionVPhotos.visibleCells) {
        
        if (![cell isKindOfClass:[LoaderCollectionCell class]]){
            
            NSInteger section=[self.collectionVPhotos indexPathForCell:cell].section;
            Page *page=[[PagesCollection sharedManager] pageAtIndex:section];
            if (page != nil){
                
                if (page.photos==nil){
                    [self fetchDataFromAPIForPage:page.pageNumber];
                    break;
                }
            }
        }
    }
}








#pragma mark - Warnings

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    
    for (UICollectionViewCell *cell in self.collectionVPhotos.visibleCells) {
        
        if (![cell isKindOfClass:[LoaderCollectionCell class]]){
            
            NSInteger section=[self.collectionVPhotos indexPathForCell:cell].section;
            
            Page *page=[[PagesCollection sharedManager] pageAtIndex:section];
            if (page != nil){
                
                if (page.photos != nil){
                    
                    [[PagesCollection sharedManager] clearAllPhotosExceptForCurrentPage:page.pageNumber];
                    [self.collectionVPhotos reloadData];
                    break;
                }
            }
        }
    }
}


@end
