//
//  CoinView.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/12/24.
//

import SwiftUI

struct CoinView: View {
    
    var totalCoin: Int
    
    var body: some View {
        HStack{
            Image("coin")
                .resizable()
                .frame(width: 40, height: 40)
            Text("\(totalCoin)")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.yellow) // Yellow text
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Color.white.opacity(0.7)
                )
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    CoinView(totalCoin:1000)
}
