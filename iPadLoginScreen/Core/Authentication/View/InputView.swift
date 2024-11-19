//
//  InputView.swift
//  iPadLoginScreen
//
//  Created by Khachatur Sargsyan on 16.11.24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
        
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(Color(.systemBlue))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
            }
            
            Rectangle()
                .fill(Color(.systemBlue))
                .frame(height: 1)
                .cornerRadius(2)
                
        }
    }
}

#Preview {
    InputView(
        text: .constant("text"),
        title: "title",
        placeholder: "placeholder"
    )
}
