import Foundation
import UIKit

class CustomView: UIView {
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font.withSize(13)
        return label
    }()
    
    var textArray: [String] = []
    var value: Value?
    var imageView: UIImageView?
    var segment: UISegmentedControl?
    
    init(frame: CGRect, row: Int, value: Value) {
        super.init(frame: frame)
        self.value = value
        self.addCustomView(row)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView(_ row: Int) {
        let labelWidth: CGFloat = 200
        let labelHeight: CGFloat = 50
        view.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        for (index, _) in value!.data[2].data.variants!.enumerated() {
            textArray.append(value!.data[2].data.variants![index].text)
        }
        
        switch row {
        case 0:
            textLabel.frame = CGRect(x: view.frame.midX - labelWidth / 2,
                                     y: view.frame.midY - labelHeight / 2,
                                     width: labelWidth,
                                     height: labelHeight)
            textLabel.text = value?.data[row].data.text
            textLabel.textAlignment = .center
            view.addSubview(textLabel)
            self.addSubview(view)
        case 1:
            textLabel.frame = CGRect(x: view.frame.midX - labelWidth / 2,
                                     y: view.frame.midY - labelHeight + 50,
                                     width: labelWidth,
                                     height: labelHeight)
            textLabel.text = value?.data[row].data.text
            textLabel.textAlignment = .center
            imageView = UIImageView()
            imageView?.frame = CGRect(x: 20,
                                      y: 40,
                                      width: view.frame.size.width - 40,
                                      height: view.frame.size.height / 2 - 80)
            let url = URL(string: value?.data[row].data.url ?? "")
            if let data = try? Data(contentsOf: url!) {
                imageView?.image = UIImage(data: data)
            }
            view.addSubview(textLabel)
            view.addSubview(imageView!)
            self.addSubview(view)
        case 2:            
            textLabel.frame = CGRect(x: view.frame.midX - labelWidth / 2,
                                     y: view.frame.midY - labelHeight + 50,
                                     width: labelWidth,
                                     height: labelHeight)
            textLabel.textAlignment = .center
            
            let items = ["\(value?.data[row].data.variants![0].id ?? 0)",
                        "\(value?.data[row].data.variants![1].id ?? 0)",
                        "\(value?.data[row].data.variants![2].id ?? 0)"]
            
            segment = UISegmentedControl(items: items)
            
            segment?.selectedSegmentIndex = value?.data[row].data.selectedId ?? 0
            
            textLabel.text = value?.data[row].data.variants![segment!.selectedSegmentIndex].text
            
            segment?.frame = CGRect(x: 20,
                                    y: view.frame.size.height - 110,
                                    width: view.frame.size.width - 40,
                                    height: 50)
            
            segment?.layer.cornerRadius = 5.0
            segment?.tintColor = .white
            segment?.backgroundColor = .lightGray
            
            segment?.addTarget(self, action: #selector(changed(sender:row:array:)), for: .valueChanged)
            
            view.addSubview(textLabel)
            view.addSubview(segment!)
            self.addSubview(view)
        default:
            return
        }
    }
    
    @objc func changed(sender: UISegmentedControl, row: Int, array: [String]) {
        switch sender.selectedSegmentIndex {
        case 0:
            textLabel.text = textArray[0]
            print(sender.selectedSegmentIndex)
        case 1:
            textLabel.text = textArray[1]
            print(sender.selectedSegmentIndex)
        case 2:
            textLabel.text = textArray[2]
            print(sender.selectedSegmentIndex)
        default:
            return
        }
    }
}
