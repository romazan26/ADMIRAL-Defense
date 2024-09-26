//
//  BattleFieldViewmodel.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI
import Combine

struct GridElement: Identifiable {
    let id = UUID()
    var position: Int
    var hero: BattleHero
    var creationTime: Date  // Время создания элемента
}

final class BattleFieldViewmodel: ObservableObject {
    @Published var healthBattleField = 100
    @Published var moneyBattleField = 0
    
    //MARK: - Proerties
    // Таймер для добавления новых элементов
    private var addElementTimer: AnyCancellable?
    
    // Таймер для проверки времени существования элементов
    private var printPositionTimer: AnyCancellable?
    
    // Время старта таймера
    private var timerStartTime: Date?
    
    // Ограничение на время работы таймера
    private let maxTimerDuration: TimeInterval = 15.0
    
    let rows = 6
    let columns = 4
    let totalCells = (6 * 4)
    
    // Массив для хранения всех элементов
    @Published var elements: [GridElement] = []
    
    //MARK: - Add demage health
    func demadge(){
        healthBattleField -= 1
        if healthBattleField <= 0 {
            stopTimers()
        }
    }
    
    //MARK: - Add coins
    func addCoins(countCoins: Int){
        moneyBattleField += countCoins
    }
    
    //MARK: - Функция для добавления элемента в случайную незанятую ячейку
    func addRandomElement() {
        // Если все ячейки заняты, не добавляем новые элементы
        guard elements.count < totalCells else { return }
        
        var newIndex: Int
        repeat {
            newIndex = Int.random(in: 0..<totalCells)
        } while elements.contains(where: { $0.position == newIndex })
        
        // Создаем новый элемент
        let newElement = GridElement(position: newIndex,
                                     hero: BattleHero.random(),
                                     creationTime: Date() )
        elements.append(newElement)
    }
    //MARK: - Функция для удаления элемента из массива
    func removeElement(at position: Int) {
        elements.removeAll { $0.position == position }
    }
    
    //MARK: - Delete element radius 1
    func removeElementAndNeighbors(at position: Int) {
        // Получаем все позиции, которые нужно удалить (сам элемент + соседи)
        let positionsToRemove = getNeighbors(for: position)
        
        // Удаляем элементы, которые находятся на этих позициях
        elements.removeAll { positionsToRemove.contains($0.position) }
    }
    
    // Получение всех соседних позиций в радиусе 1 ячейки
    func getNeighbors(for position: Int) -> [Int] {
        let row = position / columns
        let col = position % columns
        var neighbors: [Int] = []
        
        // Проходим по всем ячейкам в радиусе 1
        for i in -1...1 {
            for j in -1...1 {
                let neighborRow = row + i
                let neighborCol = col + j
                
                // Проверяем, что соседние ячейки находятся внутри сетки
                if neighborRow >= 0 && neighborRow < rows && neighborCol >= 0 && neighborCol < columns {
                    let neighborPosition = neighborRow * columns + neighborCol
                    neighbors.append(neighborPosition)
                }
            }
        }
        return neighbors
    }
    
    //MARK: -  Таймеры для работы приложения
    func startTimers() {
        startElementAdditionTimer()
        startPositionPrintingTimer()
    }
    
    // Таймер для добавления новых элементов
    private func startElementAdditionTimer() {
           timerStartTime = Date()  // Запоминаем время старта
           addElementTimer = Timer.publish(every: 2.0, on: .main, in: .common)
               .autoconnect()
               .sink { [weak self] _ in
                   guard let self = self else { return }
                   
                   // Проверяем, сколько времени прошло с начала таймера
                   if let startTime = self.timerStartTime {
                       let elapsedTime = Date().timeIntervalSince(startTime)
                       if elapsedTime >= self.maxTimerDuration {
                           // Останавливаем таймер, если прошло 15 секунд
                           print("Таймер добавления остановлен через \(self.maxTimerDuration) секунд.")
                           self.stopElementAdditionTimer()
                       } else {
                           // Добавляем новый элемент, если таймер ещё работает
                           self.addRandomElement()
                       }
                   }
               }
       }
    
    // Таймер позиции элемента, если он существует более 1 секунд
    private func startPositionPrintingTimer() {
        printPositionTimer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.checkElementAges()
                
            }
    }
    // Проверка времени существования элементов и вывод их позиции
    private func checkElementAges() {
        let currentTime = Date()
        for element in elements {
            let age = currentTime.timeIntervalSince(element.creationTime)
            if age > 1 {
                demadge()
                print("health \(healthBattleField) ")
            }
        }
    }
    // Остановка таймера добавления новых элементов
       private func stopElementAdditionTimer() {
           addElementTimer?.cancel()
           addElementTimer = nil
       }
    
    // Функция для остановки всех таймеров
    func stopTimers() {
        addElementTimer?.cancel()
        printPositionTimer?.cancel()
    }
}
