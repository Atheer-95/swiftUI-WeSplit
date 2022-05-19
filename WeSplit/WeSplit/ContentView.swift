//
//  ContentView.swift
//  WeSplit
//
//  Created by Atheer Othman on 11/10/1443 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPrectage = 20
    @FocusState private var amountIsFoucsed: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        // calculate total by person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPrectage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amuntPerPerson = grandTotal / peopleCount
        return amuntPerPerson
    }
    
    var originalAmount: Double {
        let tipSelection = Double(tipPrectage)
        let tipValue = checkAmount / 100 * tipSelection
        let originalAmount = checkAmount + tipValue
        return originalAmount
    }
    
    var body: some View {
  
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.numberPad)
                        .focused($amountIsFoucsed)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0)")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPrectage){
                        ForEach(0..<101, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much tip do you want to leave ?")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per persone")
                }
                
                Section{
                    Text("\(originalAmount)")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFoucsed = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
