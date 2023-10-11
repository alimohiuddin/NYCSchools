//
//  SchoolListVC.swift
//  20230314-AliMohiuddin-NYCSchools
//
//  Created by Ali Mohiuddin on 14/03/23.
//

import UIKit

class SchoolListVC: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableViewObj: UITableView!
    var schoolList : [Schools] = []
    var filterArray : [Schools] = []
    var isSearching : Bool = false
    private var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "School List"
        self.tableViewObj.register(UINib.init(nibName: "SchoolListCell", bundle: nil), forCellReuseIdentifier: "SchoolListCell")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableViewObj.refreshControl = refreshControl
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            AJProgressHud.sharedInstance.show(withTitle: "Loading...")
        }
        self.getSchoolList()
        
    }
    // MARK: - Pull to refresh Methods
    @objc func pullToRefresh() {
        self.getSchoolList()
    }
    func endRefresh() {
        DispatchQueue.main.async {
            if let refreshControl = self.tableViewObj.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
    }
    
    func getSchoolList(){
        ViewModel.shared.getSchoolListServiceCall { Result in
            ViewModel.shared.hideHud()
            self.endRefresh()
            switch Result{
            case .success(let result):
                self.schoolList = result
                DispatchQueue.main.async {
                    self.tableViewObj.reloadData()
                }
            case .failure(let error):
                ViewModel.shared.presentErrorMessage(viewController: self, errorMessage: error)
            }
        }
    }
}

// MARK: - tableView DataSource And Delegate Methods

extension SchoolListVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching {
           return self.filterArray.count
        }else{
            return self.schoolList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var schoolObj : Schools?
        if self.isSearching {
            schoolObj = self.filterArray[indexPath.row]
        }else{
            schoolObj = self.schoolList[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolListCell") as! SchoolListCell
        cell.dataSource(item: schoolObj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var schoolObj : Schools?
        if self.isSearching {
            schoolObj = self.filterArray[indexPath.row]
        }else{
            schoolObj = self.schoolList[indexPath.row]
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SchoolDetailVC") as! SchoolDetailVC
        vc.dbnObj = schoolObj?.dbn ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        self.searchTF.resignFirstResponder()
    }
    
}
// MARK: -  Textfield Delegate Methods for search

extension SchoolListVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        self.isSearching = true
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        if txtAfterUpdate.count > 0
        {
            self.filterArray = self.schoolList.filter({($0.school_name?.lowercased().contains(txtAfterUpdate.lowercased()))!})
        }
        else
        {
            self.isSearching = false
        }
        self.tableViewObj.reloadData()
        
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
}
