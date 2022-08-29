import UIKit

class BaseHeaderFooterView<T>: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
        setLayout()
        configureCell()
        if traitCollection.userInterfaceStyle == .dark { darkConfigure() }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addView(){}
    func setLayout(){}
    func setLayoutSubviews(){}
    func configureCell(){}
    var model: T? {
        didSet { if let model = model { bind(model) } }
    }
    func darkConfigure(){}
    func bind(_ model: T){}
}
