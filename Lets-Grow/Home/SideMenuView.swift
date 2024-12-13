//
//  SideMenuView.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/12/24.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Divider()
                .padding(.vertical, 40)
            
            // NavigationLinks now have a NavigationView context
            List {
                NavigationLink(destination: ShopView()) {
                    Text("Main Shop")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                NavigationLink(destination: OrgShopView()) {
                    Text("SJSU Shop")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.top)
        .shadow(radius: 5)
    }
}


