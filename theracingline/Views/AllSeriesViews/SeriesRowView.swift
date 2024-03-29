//
//  SeriesRowView.swift
//  theracingline
//
//  Created by David Ellis on 13/11/2020.
//

import SwiftUI
import SwiftDate

struct SeriesRowView: View {
    
    @ObservedObject var data = DataController.shared

    var seriesSessions: [Session]
    var currentDate = Date()
    
    var body: some View {
        
        let gradientStart = Color(red: seriesSessions[0].darkR / 255, green: seriesSessions[0].darkG / 255, blue: seriesSessions[0].darkB / 255)
        let gradientEnd = Color(red: seriesSessions[0].lightR / 255, green: seriesSessions[0].lightG / 255, blue: seriesSessions[0].lightB / 255)
        
        HStack{
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(
                      gradient: .init(colors: [gradientStart, gradientEnd]),
                      startPoint: .init(x: 0.5, y: 0),
                      endPoint: .init(x: 0.5, y: 0.6)
                    ))
                .frame(width: 8)
            VStack(alignment: .leading, spacing: 5) {
                Text(seriesSessions[0].series)
                    .font(.title2)
                    .fontWeight(.bold)

                if data.userAccessLevel < 3 || seriesSessions[0].sessionType != "R" {
                    Text("\(seriesSessions[0].circuit) - \(seriesSessions[0].sessionName)")
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                } else {
                    if seriesSessions[0].duration == 0 {
                        Text("\(seriesSessions[0].circuit) - \(seriesSessions[0].sessionName) - TBA Distance")
                            .font(.caption)
                            .foregroundColor(Color.secondary)
                    } else if seriesSessions[0].durationType == "AD"{
                        Text("\(seriesSessions[0].circuit) - \(seriesSessions[0].getDurationText())")
                            .font(.caption)
                            .foregroundColor(Color.secondary)
                    } else {
                        Text("\(seriesSessions[0].circuit) - \(seriesSessions[0].sessionName) \(seriesSessions[0].getDurationText())")
                            .font(.caption)
                            .foregroundColor(Color.secondary)
                    }
                }
                
                HStack{
                    if data.userAccessLevel < 3 {
                        Text("\(seriesSessions[0].day()) \(seriesSessions[0].dateAsString())")
                    } else {
                        if seriesSessions[0].tba {
                            Text("\(seriesSessions[0].day()) \(seriesSessions[0].dateAsString()) - Time TBA")
                        } else if seriesSessions[0].durationType == "AD"{
                            Text("\(seriesSessions[0].day()) \(seriesSessions[0].dateAsString())")
                        } else {
                            Text("\(seriesSessions[0].day()) \(seriesSessions[0].dateAsString()) - \(seriesSessions[0].timeAsString())")
                        }
                        
                    }
                    Spacer()
                    if data.userAccessLevel >= 3 && (seriesSessions[0].durationType != "AD" || seriesSessions[0].date > currentDate + 6.hours) {
                        Text(seriesSessions[0].timeFromNow())
                        Image(systemName: "clock.fill")
                    } else if data.userAccessLevel >= 3 && (seriesSessions[0].durationType == "AD" || seriesSessions[0].date <= currentDate) {
                        Text("All Day Event")
                        Image(systemName: "clock.fill")
                    }
                    
                    
                } // HStack
                .font(.caption)
                .foregroundColor(Color.secondary)
            } // VSTACK
        } //HSTACK
        
    }
}

struct SeriesRowView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesRowView(seriesSessions: [testSession1,testSession2,testSession3,testSession4])
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(height: 100)
        SeriesRowView(seriesSessions: [testSession8,testSession2,testSession3,testSession4])
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(height: 100)
    }
}
