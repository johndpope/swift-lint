/*
   Copyright 2015 Ryuichi Saito, LLC and the Yanagiba project contributors

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import Foundation

import AST

protocol Rule {
  var identifier: String { get }
  var name: String { get }
  var description: String { get }
  var markdown: String { get }

  func emitIssue(_: Issue)
  func inspect(_: ASTContext, configurations: [String: Any]?)
}

extension Rule {
  var identifier: String {
    return name.toIdentifier
  }

  func emitIssue(_ issue: Issue) {
    IssuePool.shared.add(issue: issue)
  }
}

fileprivate extension String {
  fileprivate var toIdentifier: String {
    return self.lowercased()
      .components(separatedBy: .punctuationCharacters)
      .joined(separator: "")
      .components(separatedBy: .whitespaces)
      .filter { !$0.isEmpty }
      .joined(separator: "_")
  }
}
