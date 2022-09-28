

import UIKit

extension UICollectionView {
    
    public func ly_registNib<T: UICollectionViewCell>(_ type: T.Type) {
        let name = String(describing: type)
        register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: type.description())
    }
    
    public func ly_registClass<T: UICollectionViewCell>(_ type: T.Type) {
        register(type, forCellWithReuseIdentifier: type.description())
    }
    
    public func ly_dequeue<T: UICollectionViewCell>(_ type: T.Type, _ index:IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.description(), for: index) as! T
    }
    
    
}
