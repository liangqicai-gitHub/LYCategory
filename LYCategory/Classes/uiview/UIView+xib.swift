import UIKit
import RxSwift
import RxCocoa

extension UIView{
    
    public static func ly_loadXib(_ bundle: Bundle? = nil) -> Self {
        let b = bundle ?? Bundle.main
        let name = String(describing: self)
        return b.loadNibNamed(name, owner: nil, options: nil)!.first as! Self
    }
    
    @IBInspectable var ly_cornerRadius: CGFloat {
        get { return layer.cornerRadius}
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var ly_borderWidth: CGFloat {
        get { return layer.borderWidth}
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var ly_borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    public var ly_shadowColor: UIColor? {
        get {
            return layer.shadowColor == nil ? nil : UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    // The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
   public var ly_shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// The shadow offset. Defaults to (0, -3). Animatable.
    public var ly_shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    public var ly_masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    
    /// The blur radius used to create the shadow. Defaults to 3. Animatable.
    public var ly_shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    public func ly_setCorner(corner: CGFloat = 0,
                             borderWidth: CGFloat = 0,
                             borderColor: UIColor? = nil,
                             shadowColor: UIColor? = nil,
                             shadowOpacity: CGFloat = 0.0,
                             shadowOffset: CGSize = CGSize(width: 0, height: 2),
                             shadowRadius: CGFloat = 3,
                             maskToBounds: Bool = false,
                             notSureBounds: Bool = true)
    {
        self.ly_cornerRadius = corner
        self.ly_borderWidth = borderWidth
        self.ly_borderColor = borderColor
        self.layer.masksToBounds = maskToBounds
        
        if shadowOpacity > 0.0 {
            self.ly_shadowColor = shadowColor
            self.ly_shadowOpacity = Float(shadowOpacity)
            self.ly_shadowOffset = shadowOffset
            self.ly_shadowRadius = shadowRadius
            
            //使用shadowpath，避免离屏渲染
            func innerSet(corners: UIRectCorner, radius: CGFloat, suredBounds: CGRect) {
                let maskPath = UIBezierPath.init(roundedRect: suredBounds,
                                                 byRoundingCorners: corners,
                                                 cornerRadii: CGSize(width: radius, height: radius))
                layer.shadowPath = maskPath.cgPath
            }
            
            innerSet(corners: .allCorners, radius: corner, suredBounds: bounds)
            
            if notSureBounds {
                ly_afterLayout { [weak self] in
                    guard let sself = self else {return}
                    innerSet(corners: .allCorners, radius: corner, suredBounds: sself.bounds)
                }
            }
            
        }
    }
    
    
    
    
    public func setRoundedCorners(corners: UIRectCorner, radius: CGFloat, notSureBounds: Bool = true) {
        
        func innerSet(corners: UIRectCorner, radius: CGFloat, suredBounds: CGRect) {
            let maskPath = UIBezierPath.init(roundedRect: suredBounds,
                                             byRoundingCorners: corners,
                                             cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = suredBounds
            maskLayer.path = maskPath.cgPath
            layer.mask = maskLayer
        }
        
        
        innerSet(corners: corners, radius: radius, suredBounds: bounds)
        
        if notSureBounds {
            ly_afterLayout { [weak self] in
                guard let sself = self else {return}
                innerSet(corners: corners, radius: radius, suredBounds: sself.bounds)
            }
        }
    }
    
    
    
    
    /// viewWithTag 的更为方便的写法
    /// - Parameters:
    ///   - tag: tag
    ///   - generateBlock: 如果没有这个，就自己去生成，并且自己需要在这个block中处理添加view上，并且布局
    /// - Returns: 这个view
    public func ly_view<T: UIView>(with tag: Int, generateBlock: (() -> T)? = nil ) -> T? {
        
        if let rs = viewWithTag(tag) as? T { return rs }
        guard let rs = generateBlock?() else { return nil }
        rs.tag = tag
        
        return rs
    }
    
    
    
    public func ly_afterLayout(block: @escaping ()-> Void) {
        var dis: Disposable? = nil
        dis = rx.methodInvoked(#selector(self.layoutSubviews))
            .take(until: rx.deallocated)  //假如这个方法一直不调用，那也需要销毁
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                dis?.dispose()
                block()
            })
    }
}

