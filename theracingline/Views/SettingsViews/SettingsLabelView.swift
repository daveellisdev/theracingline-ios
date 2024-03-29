//
//  SettingsLabelView.swift
//  theracingline
//
//  Created by David Ellis on 14/11/2020.
//

import SwiftUI

struct SettingsLabelView: View {
    var labelText: String
    var labelImage: String
    
    var body: some View {
        HStack {
            Text(labelText).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()

            Image(systemName: labelImage)
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "About", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
