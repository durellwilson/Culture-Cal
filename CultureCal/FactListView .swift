//
//  FactListView .swift
//  CultureCal
//
//  Created by Kelly Brown on 5/18/23.
//

import SwiftUI

struct FactListView: View {
    let dataSource: [String: Fact]
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dataSource.sorted(by: { $0.key < $1.key }), id: \.key) { key, fact in
                    VStack(alignment: .leading) {
                        Text(key)
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(fact.title)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationBarTitle("Black Historical Facts")
            .navigationBarItems(trailing: Button(action: {
                isPresented = false
            }) {
                Text("Done")
            })
        }
    }
}
