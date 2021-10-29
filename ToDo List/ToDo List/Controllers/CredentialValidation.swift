//
//  CredentialValidation.swift
//  ToDo List
//
//  Created by Serhii on 28.10.2021.
//

import Foundation
import UIKit

protocol CredentialsInterface {
   var email: String? { get set }
   var password: String? { get set }
   
   func validate(label: UILabel!) -> Bool
}
