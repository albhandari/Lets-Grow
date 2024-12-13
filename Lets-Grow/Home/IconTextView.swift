//
//  IconTextView.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/12/24.
//

import SwiftUI

struct IconTextView: View {
    
    let iconName: String
    let iconImage: String
    
    var body: some View {
        VStack{
            Image(iconImage)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
            
            Text(iconName)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    IconTextView(iconName: "Regular", iconImage: "regular_mode_icon")
}
