//
//  GMWebViewController.m
//  GoodWine
//
//  Created by LMK on 2019/10/10.
//  Copyright © 2019年 LMK. All rights reserved.
//

#import "GMWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>

static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface GMWebViewController () <WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, assign) BOOL adapter;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation GMWebViewController

- (instancetype)initNeedAdapter:(BOOL)adapter {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.adapter = adapter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateNavigationBarNeedBack:YES];
    
    if (self.urlString.length>0) {
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [self.webView loadRequest:request];
        
        //添加进度条
        [self.view addSubview:self.progressView];
        //添加右边刷新按钮
        UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadLoadClicked)];
        self.navigationItem.rightBarButtonItem = roadLoad;
    }
    [self setupConstranits];
}

- (void)setupConstranits {
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)roadLoadClicked{
    [self.view addSubview:self.webView];
    [self.webView reload];
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    //    禁止 WKWebView 的捏合手势，双击放大缩小等操作
//    NSString *javascript = @"var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);";
//    [webView evaluateJavaScript:javascript completionHandler:nil];
//}

- (WKWebView *)webView{
    if (! _webView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        //允许视频播放
        if (@available(iOS 9.0, *)) {
            Configuration.allowsAirPlayForMediaPlayback = YES;
        } else {
            // Fallback on earlier versions
        }
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        if (self.adapter) {
            NSString *jsStr = @"var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=0.1, maximum-scale=1, user-scalable=yes');document.getElementsByTagName('head')[0].appendChild(meta);";
    
    //        NSString *jsStr = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //
    ////        NSString *jsStr = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
            WKUserScript *wkScript = [[WKUserScript alloc] initWithSource:jsStr injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    //        // 添加js调用
            [UserContentController addUserScript:wkScript];
        }
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:Configuration];
    
        _webView.UIDelegate = self;

        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
//        _webView.allowsBackForwardNavigationGestures = YES;
//        [_webView sizeToFit];
        [self.view addSubview:self.webView];
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, SafeAreaTopHeight, self.view.bounds.size.width, 3);
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

@end
