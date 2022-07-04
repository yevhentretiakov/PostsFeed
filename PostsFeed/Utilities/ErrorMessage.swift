//
//  ErrorMessage.swift
//  PostsFeed
//
//  Created by user on 03.07.2022.
//

import Foundation

enum ErrorMessage: String, Error {
    case unableToComplete = "Unable to complete your request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
