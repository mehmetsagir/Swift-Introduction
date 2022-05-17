//
//  Home.swift
//  HabitTracker
//
//  Created by Mehmet Sağır on 13.05.2022.
//

import SwiftUI

struct Home: View {
    @FetchRequest(entity: Habit.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Habit.dateAdded, ascending: false)], predicate: nil, animation: .easeInOut)
    var habits: FetchedResults<Habit>
    
    @StateObject var habitModel: HabitViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Habbits")
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 10)
            ScrollView(habits.isEmpty ? .init() : .vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    
                    ForEach(habits) {habit in
                        HabitCardView(habit: habit)
                    }
                    
                    Button {
                        habitModel.addNewHabit.toggle()
                    } label: {
                        Label {
                            Text("New Habbit")
                        } icon: {
                            Image(systemName: "plus.circle")
                        }
                        .font(.callout.bold())
                        .foregroundColor(.white)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .sheet(isPresented: $habitModel.addNewHabit) {
                        habitModel.resetData()
                        
                    } content: {
                        AddNewHabit()
                            .environmentObject(habitModel)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
    
    @ViewBuilder
    func HabitCardView(habit: Habit) -> some View {
        VStack(spacing: 6) {
            HStack {
                Text(habit.title ?? "")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "bell.bagde.fill")
                    .font(.callout)
                    .foregroundColor(Color(habit.color ?? "Card-1"))
                    .scaleEffect(0.9)
                    .opacity(habit.isRemainderOn ? 1 : 0)
                
                let count = (habit.weekDays?.count ?? 0)
                Text(count == 7 ? "Everyday" : "\(count) times a week")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
            
            let calendar = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfYear, for: Date())
            let symbols = calendar.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
            let activeWeekDays = habit.weekDays ?? []
            let activePlot = symbols.indices.compactMap { index -> (String, Date) in
                let currenctDate = calendar.date(byAdding: .day, value: index, to: startDate)
                return (symbols[index], currenctDate!)
            }
            
            HStack(spacing: 0) {
                ForEach(activePlot.indices, id: \.self) { index in
                    let item = activePlot[index]
                    
                    VStack(spacing: 6) {
                        Text(item.0.prefix(0))
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        let status = activeWeekDays.contains { day in
                            return day == item.0
                        }
                        
                        Text(getDate(date: item.1))
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(Color(habit.color ?? "Card-1"))
                                    .opacity(status ? 1 : 0)
                            }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 15)
        }
        .padding(.vertical)
        .padding(.horizontal, 6)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color("TFBG").opacity(0.5))
        }
        .onTapGesture {
            habitModel.editHabit = habit
            habitModel.restoreEditData()
            habitModel.addNewHabit.toggle()
        }
    }
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
