//
//  SchoolModal.swift
//  20230314-AliMohiuddin-NYCSchools
//
//  Created by Ali Mohiuddin on 14/03/23.
//

import Foundation

// MARK: - School Model entities:

struct Schools : Codable{
    var school_name : String?
    var overview_paragraph : String?
    var phone_number : String?
    var school_email : String?
    var dbn : String?
}

// MARK: - School Details entities:

struct SchoolDetail : Codable{
    var school_name : String?
    var num_of_sat_test_takers : String?
    var sat_critical_reading_avg_score : String?
    var sat_math_avg_score : String?
    var sat_writing_avg_score : String?
    var dbn : String?
}
