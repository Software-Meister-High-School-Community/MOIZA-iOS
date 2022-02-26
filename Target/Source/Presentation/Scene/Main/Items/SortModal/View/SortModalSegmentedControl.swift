import UIKit

protocol SortModalSegmentedControlDelegate: AnyObject {
    func segmentValueChanged(to index: Int)
}

final class SortModalSegmentedControl: UIView {
    
    weak var delegate: SortModalSegmentedControlDelegate?
    private var titles: [String] = []
    private var buttons: [UIButton] = []
    
    var unselectedTextColor: UIColor = .black
    var selectedTextColor: UIColor = .white
    var selectedBackgroundColor: UIColor = MOIZAAsset.moizaPrimaryYellow.color
    var unselectedBackgroundColor: UIColor = .white
    var borderColor: UIColor = .clear
    public private(set) var selectedIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init (
        titles: [String]
    ) {
        self.init(frame: .zero)
        self.titles = titles
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    fileprivate func updateView() {
        setButtons()
        configStack()
    }
    
    fileprivate func setButtons() {
        self.buttons = []
        self.subviews.forEach{ $0.removeFromSuperview() }
        titles.forEach {
            let button = UIButton()
            button.setTitle($0, for: .normal)
            button.setTitleColor(unselectedTextColor, for: .normal)
            button.backgroundColor = unselectedBackgroundColor
            button.layer.borderWidth = 1
            button.layer.borderColor = borderColor.cgColor
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
    }
    
    fileprivate func configStack() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    @objc private func buttonDidTapped(_ sender: UIButton) {
        buttons.enumerated().forEach{ index, button in
            button.setTitleColor(unselectedTextColor, for: .normal)
            button.layer.borderColor = borderColor.cgColor
            button.setBackgroundColor(unselectedBackgroundColor, for: .normal)
            if button == sender {
                button.setTitleColor(selectedTextColor, for: .normal)
                button.layer.borderColor = UIColor.clear.cgColor
                button.setBackgroundColor(selectedBackgroundColor, for: .normal)
                self.selectedIndex = index
                self.delegate?.segmentValueChanged(to: index)
            }
        }
    }
}
