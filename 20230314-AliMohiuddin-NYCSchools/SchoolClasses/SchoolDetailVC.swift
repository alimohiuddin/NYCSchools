//
//  SchoolDetailVC.swift
//  20230314-AliMohiuddin-NYCSchools
//
//  Created by Ali Mohiuddin on 14/03/23.
//

import UIKit

class SchoolDetailVC: UIViewController {
    @IBOutlet weak var tableViewObj: UITableView!
    var schoolDetail : [SchoolDetail] = []
    var dbnObj : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "School Detail"
        // Do any additional setup after loading the view.
        self.tableViewObj.register(UINib.init(nibName: "SchoolDetailCell", bundle: nil), forCellReuseIdentifier: "SchoolDetailCell")
        self.tableViewObj.register(UINib.init(nibName: "NoDataCell", bundle: nil), forCellReuseIdentifier: "NoDataCell")
        
        
        // Show Loader for wait and UI Update
        AJProgressHud.sharedInstance.show(withTitle: "Loading...")
        
        ViewModel.shared.getSchoolDetailServiceCall(dbn: self.dbnObj) { Result in
            ViewModel.shared.hideHud()
            switch Result{
            case .success(let result):
                self.schoolDetail = result
                DispatchQueue.main.async {
                    self.tableViewObj.reloadData()
                }
            case .failure(let error):
                ViewModel.shared.presentErrorMessage(viewController: self, errorMessage: error)
            }
        }
    }
}
//MARK: tableView DataSource And Delegate Methods

extension SchoolDetailVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.schoolDetail.count > 0{
            return self.schoolDetail.count
        }else {return 1}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.schoolDetail.count > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolDetailCell") as! SchoolDetailCell
            cell.dataSource(item: self.schoolDetail[indexPath.row])
            return cell
        }else {
            let NodataCell = tableView.dequeueReusableCell(withIdentifier: "NoDataCell") as! NoDataCell
            return NodataCell
        }
            
    }
}
