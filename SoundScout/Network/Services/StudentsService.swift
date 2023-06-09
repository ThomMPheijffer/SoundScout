//
//  StudentService.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 31/05/2023.
//

import Foundation

protocol StudentsServiceable {
    func getAllStudents() async -> Result<Students, RequestError>
    func getStudentDetails(id: String) async -> Result<Student, RequestError>
    func postStudent(student: SignUpStudent) async -> Result<StudentResponse, RequestError>
    func addTeacherToStudent(studentId: String, body: AddTeacherToStudentModel) async -> Result<StudentResponse, RequestError>
    func getTeachers(studentId: String) async -> Result<Teachers, RequestError>
}

struct StudentsService: HTTPClient, StudentsServiceable {
    func getAllStudents() async -> Result<Students, RequestError> {
        return await sendRequest(endpoint: StudentEndpoint.getStudents, responseModel: Students.self)
    }
    
    func getStudentDetails(id: String) async -> Result<Student, RequestError> {
        return await sendRequest(endpoint: StudentEndpoint.getStudentDetails(id: id), responseModel: Student.self)
    }
    
    func postStudent(student: SignUpStudent) async -> Result<StudentResponse, RequestError> {
        return await sendRequest(endpoint: StudentEndpoint.postStudent(student: student), responseModel: StudentResponse.self)
    }
    
    func addTeacherToStudent(studentId: String, body: AddTeacherToStudentModel) async -> Result<StudentResponse, RequestError> {
        return await sendRequest(endpoint: StudentEndpoint.addTeacherToStudent(studentId: studentId, body: body), responseModel: StudentResponse.self)
    }
    
    func getTeachers(studentId: String) async -> Result<Teachers, RequestError> {
        return await sendRequest(endpoint: StudentEndpoint.getTeachers(studentId: studentId), responseModel: Teachers.self)
    }
}
