//
//  ViewModel.swift
//  20230314-AliMohiuddin-NYCSchools
//
//  Created by Ali Mohiuddin on 14/03/23.
//

import Foundation
import UIKit

class ViewModel {
    
    static let shared = ViewModel()
    
    private init(){}
    
    // MARK: -  Api End Points
    
    struct ApiEndPoints {
        static let schoolListURL : String = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
 static let schoolDetailURL : String = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn="
    }
    
    // MARK: - Server Call for School List:
    
    func getSchoolListServiceCall(completionHandler:@escaping(Result<[Schools],Error>)-> Void){
        
        guard let url = URL(string: ApiEndPoints.schoolListURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error{
                completionHandler(.failure(error))
            }else if let data = data{
                do{
                    var result = try JSONDecoder().decode([Schools].self, from: data)
                    result = result.sorted(by: {$0.school_name ?? "" > $1.school_name ?? ""})
                    
                    completionHandler(.success(result))
                }catch{
                    completionHandler(.failure(error))
                }
            }else {
                completionHandler(.failure(error!))
            }
            
        }.resume()
        
    }
    
    // MARK: - Server Call for School Detail:
    
    func getSchoolDetailServiceCall(dbn : String?,completionHandler:@escaping(Result<[SchoolDetail],Error>)-> Void){
        
        
        guard let url = URL(string: ApiEndPoints.schoolDetailURL.appending(dbn ?? "")) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error{
                completionHandler(.failure(error))
            }else if let data = data{
                do{
                    let result = try JSONDecoder().decode([SchoolDetail].self, from: data)
                    completionHandler(.success(result))
                }catch{
                    completionHandler(.failure(error))
                }
            }else {
                completionHandler(.failure(error!))
            }
            
        }.resume()
        
    }
    
    // MARK: - error Alert:
    
    func presentErrorMessage(viewController : UIViewController,errorMessage: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error",
                                                    message: errorMessage.localizedDescription,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            viewController.present(alertController, animated: true)
        }
    }
    
    // MARK: - Activity Indicator Methods:
    func showHud(){
        DispatchQueue.main.async {
            AJProgressHud.sharedInstance.show()
        }
    }
    
    func hideHud(){
        DispatchQueue.main.async {
            AJProgressHud.sharedInstance.hide()
        }
    }
    
}
