//
//  StudentService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

protocol StudentsServiceable {
    func getAllStudents() async -> Result<Students, RequestError>
    func getStudentDetails(id: Int) async -> Result<Student, RequestError>
    func postStudent(student: Student) async -> Result<StudentResponse, RequestError>
}

struct StudentsService: HTTPClient, StudentsServiceable {
    func getAllStudents() async -> Result<Students, RequestError> {
        return await sendRequest(endpoint: StudentEndpoint.getStudents, responseModel: Students.self)
    }
    
    func getStudentDetails(id: Int) async -> Result<Student, RequestError> {
        return await sendRequest(endpoint: StudentEndpoint.getStudentDetails(id: id), responseModel: Student.self)
    }
    
    func postStudent(student: Student) async -> Result<StudentResponse, RequestError> {
        return await sendRequest(endpoint: StudentEndpoint.postStudent(student: student), responseModel: StudentResponse.self)
    }
}
