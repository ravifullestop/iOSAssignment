

import UIKit

class PaymentDetailController: UIViewController {

    var detailData = [CommonModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Payment Detail"
        tableView.tableFooterView = UIView()
    }
}

extension PaymentDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.detailTextLabel?.numberOfLines = 0
        
        let dict = detailData[indexPath.row]
        
        cell.textLabel?.text = dict.title
        cell.detailTextLabel?.text = dict.value
        
        return cell
    }
}
