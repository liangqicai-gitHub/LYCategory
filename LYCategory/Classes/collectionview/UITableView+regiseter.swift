

import UIKit

extension UITableView {
    
    public func ly_registNib<T: UITableViewCell>(_ type: T.Type) {
        let name = String(describing: type)
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: type.description())
    }
    
    public func ly_registClass<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.description())
    }
    
    public func ly_dequeue<T: UITableViewCell>(_ type: T.Type, _ index:IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.description(), for: index) as! T
    }
    
}


class BasePage: UIViewController {
    
}
