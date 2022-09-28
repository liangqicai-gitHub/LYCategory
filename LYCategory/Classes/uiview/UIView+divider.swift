import UIKit
import SnapKit
import RxSwift



extension UIView {
    
    private struct AssociatedKeys_di_top {
        static var topLeft = "AssociatedKeys_di_top.topleft"
        static var topRight = "AssociatedKeys_di_top.topRight"
        static var topColor = "AssociatedKeys_di_top.topColor"
        static var topView = "AssociatedKeys_di_top.topView"
        static var topHeight = "AssociatedKeys_di_top.topHeight"
        static var isShowTop = "AssociatedKeys_di_top.isShowTop"
    }

    public var ly_topLeft: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_top.topLeft, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys_di_top.topLeft) as? CGFloat) ?? 0
        }
    }
    
    
    public var ly_topRight: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_top.topRight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys_di_top.topRight) as? CGFloat) ?? 0
        }
    }
    
    
    public var ly_topColor: UIColor? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_top.topColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys_di_top.topColor) as? UIColor
        }
    }
    
    
    public var ly_topHeight: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_top.topHeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys_di_top.topHeight) as? CGFloat) ?? 1.0 / UIScreen.main.scale
        }
    }
    
    private var ly_topView: UIView? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_top.topView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys_di_top.topView) as? UIView
        }
    }
    
    private func ly_setdividerShow(_ isTop: Bool) {
        let targetView = isTop ? ly_topView : ly_bottomView
        if targetView == nil {
            let s = UIView()
            addSubview(s)
            isTop ? (ly_topView = s) : (ly_bottomView = s)
        }
        //这一段代码不要删除，某些特殊情况下这个线会渲染失败，所以我们在他layout之后再渲染一次。
        ly_afterLayout { [weak self] () in
            self?.ly_setdividerShow_resetFrame(isTop)
        }
        ly_setdividerShow_resetFrame(isTop)
    }
    
    
    private func ly_setdividerShow_resetFrame(_ isTop: Bool) {
        let targetView = isTop ? ly_topView : ly_bottomView
        let left = isTop ? ly_topLeft : ly_bottomLeft
        let right = isTop ? ly_topRight : ly_bottomRight
        let height = isTop ? ly_topHeight : ly_bottomHeight
        let color = (isTop ? ly_topColor : ly_bottomColor) ?? UIColor(hexString: "d8d8d8")
        
        targetView?.backgroundColor = color
        targetView?.snp.remakeConstraints({ (make) in
            _ = isTop ? make.top.equalToSuperview() : make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(left)
            make.right.equalToSuperview().offset(right * -1)
            make.height.equalTo(height)
        })
        targetView?.isHidden = false
    }
    
    
    //修改上面的 api 之后，要调用这个api，才会生效
    public var ly_isShowTop: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_top.isShowTop, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if newValue {
                ly_setdividerShow(true)
            } else {
                ly_topView?.isHidden = true
            }
        }
        
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys_di_top.isShowTop) as? Bool) ?? false
        }
    }
    
}



extension UIView {
    
    private struct AssociatedKeys_di_bottom {
        static var bottomLeft = "AssociatedKeys_di_bottom.bottomleft"
        static var bottomRight = "AssociatedKeys_di_bottom.bottomRight"
        static var bottomColor = "AssociatedKeys_di_bottom.bottomColor"
        static var bottomView = "AssociatedKeys_di_bottom.bottomView"
        static var bottomHeight = "AssociatedKeys_di_bottom.bottomHeight"
        static var isShowBottom = "AssociatedKeys_di_bottom.isShowBottom"
    }

    public var ly_bottomLeft: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_bottom.bottomLeft, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys_di_bottom.bottomLeft) as? CGFloat) ?? 0
        }
    }
    
    
    public var ly_bottomRight: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_bottom.bottomRight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys_di_bottom.bottomRight) as? CGFloat) ?? 0
        }
    }
    
    
    public var ly_bottomColor: UIColor? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_bottom.bottomColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys_di_bottom.bottomColor) as? UIColor
        }
    }
    
    
    public var ly_bottomHeight: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_bottom.bottomHeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys_di_bottom.bottomHeight) as? CGFloat) ?? 1.0 / UIScreen.main.scale
        }
    }
    
    private var ly_bottomView: UIView? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_bottom.bottomView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys_di_bottom.bottomView) as? UIView
        }
    }
    
    
    
    //修改上面的 api 之后，要调用这个api，才会生效
    public var ly_isShowBottom: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys_di_bottom.isShowBottom, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if newValue {
                ly_setdividerShow(false)
            } else {
                ly_bottomView?.isHidden = true
            }
        }
        
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys_di_bottom.isShowBottom) as? Bool) ?? false
        }
    }
    
    
}
