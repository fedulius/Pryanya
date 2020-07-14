import UIKit

class ViewController: UIViewController {
    
    var value: Value?
    var customView: CustomView?
    
    var scrollView: UIScrollView?
    
    let dict = ["hz": 0, "picture": 1, "selector": 2]

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView()
        scrollView?.delegate = self
        scrollView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        scrollView?.isPagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView!)
        
        MethodOfPars.parsing { (cat) in
            self.value = cat
            print(cat.view[0])
            let multi = cat.view.count
            self.scrollView?.contentSize = CGSize(width: self.view.frame.width * CGFloat(multi), height: self.view.frame.size.height)
            
            for (index, i)  in cat.view.enumerated() {
                self.customView = CustomView.init(frame: CGRect(x: self.view.frame.size.width * CGFloat(index), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), row: self.dict[i] ?? 0, value: cat)
                self.scrollView?.addSubview(self.customView!)
            }
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let number = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        print(value!.view[number])
    }
}
