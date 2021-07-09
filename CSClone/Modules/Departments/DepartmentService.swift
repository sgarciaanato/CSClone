//
//  DepartmentService.swift
//  CSClone
//
//  Created by Samuel García on 7/6/21.
//

import Foundation

class DepartmentService {
    
    func getDepartmentDetail(_ departmentIdentifier: String) -> Department? {
        guard let storeListData = Mock.loadData("Department-\(departmentIdentifier)") else { return nil}
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(Department.self, from: storeListData)
        } catch {
            debugPrint("getDepartmentDetail error:\(error)")
        }
        return nil
    }
    
}
