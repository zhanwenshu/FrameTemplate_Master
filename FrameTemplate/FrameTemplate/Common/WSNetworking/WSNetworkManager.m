//
//  WSNetworkManager.m
//  FrameTemplate
//
//  Created by zws on 2017/10/24.
//  Copyright © 2017年 vma. All rights reserved.
//

#import "WSNetworkManager.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "Base64Util.h"

#define HTTP_URL    @"http://121.40.216.49:50191/fireSchool-api-client-interface/"
#define RESP_CODE   @"result_code"
#define RESP_DATA   @"data"
#define RESP_MSG    @"result_desc"

#define kNeedHttpsAuth NO // 是否需要https授权证书

@interface WSNetworkManager ()

@end

@implementation WSNetworkManager

+ (instancetype)shareManager {
    static WSNetworkManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]initWithBaseURL:[NSURL URLWithString:HTTP_URL]];
    });
    
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        // 设置请求超时时间30秒
        self.requestSerializer.timeoutInterval = 30;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer = response;
        
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", @"text/html", nil]];
        
        if (kNeedHttpsAuth) {
            [self setSecurityPolicy:[self setCustomSecurityPolicy]];
        }
    }
    
    return self;
}

#pragma -mark 网络请求方法

+ (void)postWithAction:(NSString*)action params:(id)params successBlock:(WSRequestSuccessBlock)successBlock failureBlock:(WSRequestFailureBlock)failureBlock {
    // 检查网络是否正常
    if ([WSNetworkManager checkNetworkStatusError]) {
        failureBlock(nil, @"");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败，请检查网络！"];
        return;
    }
    
    WSNetworkManager *manager = [WSNetworkManager shareManager];
    
    /** 自定义处理请求数据
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        // 需要处理的参数
    }];
     */
    
#ifdef DEBUG
    NSLog(@"=================param=================");
    NSLog(@"%@", params);
    NSLog(@"=======================================");
#endif
    
    [manager POST:action parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary*)responseObject;
        
#ifdef DEBUG
        NSLog(@"========%@========", action);
        NSLog(@"%@", response);
        NSLog(@"=======================================");
#endif
        
        successBlock([response[RESP_CODE] integerValue], response[RESP_DATA], action, response[RESP_MSG]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error, [error localizedDescription]);
        NSLog(@"%@", [error localizedDescription]);
    }];
}

+ (void)getWithAction:(NSString*)action params:(id)params successBlock:(WSRequestSuccessBlock)successBlock failureBlock:(WSRequestFailureBlock)failureBlock {
    // 检查网络是否正常
    if ([WSNetworkManager checkNetworkStatusError]) {
        failureBlock(nil, @"");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败，请检查网络！"];
        return;
    }
    
    [[WSNetworkManager shareManager]GET:action parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary*)responseObject;
        
#ifdef DEBUG
        NSLog(@"========%@========", action);
        NSLog(@"%@", response);
        NSLog(@"=======================================");
#endif
        
        successBlock([response[RESP_CODE] integerValue], response[RESP_DATA], action, response[RESP_MSG]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error, [error localizedDescription]);
    }];
}

+ (void)uploadWithAction:(NSString*)action images:(NSArray*)images params:(id)params successBlock:(WSRequestSuccessBlock)successBlock failureBlock:(WSRequestFailureBlock)failureBlock {
    
    // 检查网络是否正常
    if ([WSNetworkManager checkNetworkStatusError]) {
        failureBlock(nil, @"");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败，请检查网络！"];
        return;
    }
    
    [[WSNetworkManager shareManager] POST:action parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < images.count; i++) {
            NSDictionary *imageDic = images[i];
            UIImage *image = [imageDic objectForKey:@"image"];
            NSString *imageName = [imageDic objectForKey:@"fileName"];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            NSString *fileName = [NSString stringWithFormat:@"%@", imageName];
            [formData appendPartWithFileData:imageData name:fileName fileName:[NSString stringWithFormat:@"%@.png", fileName] mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = (NSDictionary*)responseObject;
        
#ifdef DEBUG
        NSLog(@"========%@========", action);
        NSLog(@"%@", response);
        NSLog(@"=======================================");
#endif
        
        successBlock([response[RESP_CODE] integerValue], response[RESP_DATA], action, response[RESP_MSG]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error, [error localizedDescription]);
    }];
}

+ (void)cancelAllRequest {
    [[WSNetworkManager shareManager].operationQueue cancelAllOperations];
}

#pragma -mark 公共方法

+ (BOOL)checkNetworkStatusError {
    return [[Reachability reachabilityWithHostName:@"www.baidu.com"] currentReachabilityStatus] == NotReachable ? YES : NO;
}

#pragma -mark 私有方法

/**
 验证Https证书

 @return 证书模式的SecurityPolicy，AFSecurityPolicy有3种安全验证方式 具体看头文件的枚举
 */
- (AFSecurityPolicy *)setCustomSecurityPolicy {
    // 证书路径
    NSString *cerPath = @"xxx.cer";
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    
    //validatesCertificateChain 是否验证整个证书链，默认为YES
    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
    //GeoTrust Global CA
    //    Google Internet Authority G2
    //        *.google.com
    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证，因为整个证书链一一比对是完全没有必要（请查看源代码）；
    //    securityPolicy.validatesCertificateChain = NO;
    
    NSSet *cerDataSet = [NSSet setWithArray:@[cerData]];
    securityPolicy.pinnedCertificates = cerDataSet;
    
    return securityPolicy;
}

@end
