//
//  TeachersService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

protocol TeachersServiceable {
    func getAllTeachers() async -> Result<Teachers, RequestError>
    func getTeacherDetails(id: String) async -> Result<Teacher, RequestError>
    func postTeacher(teacher: SignUpTeacher) async -> Result<TeacherResponse, RequestError>
    func getStudents(teacherId: String) async -> Result<Students, RequestError>
}

struct TeachersService: HTTPClient, TeachersServiceable {
    func getAllTeachers() async -> Result<Teachers, RequestError> {
        return await sendRequest(endpoint: TeacherEndpoint.getTeachers, responseModel: Teachers.self)
    }
    
    func getTeacherDetails(id: String) async -> Result<Teacher, RequestError> {
        return await sendRequest(endpoint: TeacherEndpoint.getTeacherDetails(id: id), responseModel: Teacher.self)
    }
    
    func postTeacher(teacher: SignUpTeacher) async -> Result<TeacherResponse, RequestError> {
        return await sendRequest(endpoint: TeacherEndpoint.postTeacher(teacher: teacher), responseModel: TeacherResponse.self)
    }
    
    func getStudents(teacherId: String) async -> Result<Students, RequestError> {
        return await sendRequest(endpoint: TeacherEndpoint.getStudents(teacherId: teacherId), responseModel: Students.self)
    }
}
