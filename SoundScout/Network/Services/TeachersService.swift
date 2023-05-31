//
//  TeachersService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

protocol TeachersServiceable {
    func getAllTeachers() async -> Result<Teachers, RequestError>
    func getTeacherDetails(id: Int) async -> Result<Teacher, RequestError>
}

struct TeachersService: HTTPClient, TeachersServiceable {
    func getAllTeachers() async -> Result<Teachers, RequestError> {
        return await sendRequest(endpoint: TeacherEndpoint.getTeachers, responseModel: Teachers.self)
    }
    
    func getTeacherDetails(id: Int) async -> Result<Teacher, RequestError> {
        return await sendRequest(endpoint: TeacherEndpoint.getTeacherDetails(id: id), responseModel: Teacher.self)
    }
}
