//
//  HYTrailAnnotationView.m


#import "HYTrailEndAnnotationView.h"

@interface HYTrailEndAnnotationView () {
    
    CGFloat width;
}

@property (nonatomic, strong) UIImageView *imageVew;

@property (nonatomic, strong) UILabel *label_title;

@end

@implementation HYTrailEndAnnotationView

- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        CGRect frame = self.frame;
        frame.size = CGSizeMake(60.0, 32);
        self.frame = frame;
        self.contentMode = UIViewContentModeCenter;
        self.backgroundColor = [UIColor clearColor];
        self.enabled = YES;
        
        self.imageVew.frame = CGRectMake(0, 9, 15, 23);
        
        [self addSubview:self.imageVew];
        
        self.label_title.frame = CGRectMake(0, 0, 40, 9);
        
        [self addSubview:self.label_title];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    
    [super setImage:image];
    
    self.imageVew.image = [image dp_scaleToSize:CGSizeMake(15, 23)];
}

- (void)setAnnotation:(id <BMKAnnotation>)annotation {
    [super setAnnotation:annotation];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
}

- (void)setTitle:(NSString *)title {
    
    self.label_title.text = title;
    
    if(title) {
        
        width = [title dp_widthWith:[UIFont systemFontOfSize:7.5]];
        
        if(width < 40) {
            
            width = 40;
        }
    }
    else {
        
        width = 40;
    }
    
    self.label_title.frame = CGRectMake((15 - width) / 2, 0, width, 9);
}

- (UILabel *)label_title {
    
    if(!_label_title) {
        
        _label_title = [[UILabel alloc] init];
        
        _label_title.backgroundColor = [UIColor clearColor];
        
        _label_title.font = [UIFont systemFontOfSize:7.5];
        
        _label_title.textColor = [UIColor darkTextColor];
        
        _label_title.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label_title;
}

- (UIImageView *)imageVew {
    
    if (!_imageVew) {
        
        _imageVew = [[UIImageView alloc] init];
    }
    
    return _imageVew;
}

@end
