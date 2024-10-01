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
    //MARK: - Proerties
    
    @AppStorage("money") var money: Int?
    
    @Published var simpleCrore: Int = 0
    @Published var healthBattleField = 100
    @Published var moneyBattleField = 0
    @Published var simpleMoney: Int = 0
    
    @Published var gameOver: Bool = false
    @Published var gameVictory: Bool = false
    @Published var isPauseview: Bool = false
    
    // Ограничение на время работы таймера
    @Published var maxTimerDuration: TimeInterval = 15.0
    // Массив для хранения всех элементов
    @Published var elements: [GridElement] = []
    // Оставшееся время работы таймера
    @Published var remainingTime: TimeInterval = 0
    // Состояние паузы игры
    @Published var isPaused: Bool = false
    
    
    // Время, прошедшее до паузы
    private var elapsedBeforePause: TimeInterval = 0
    // Таймер для добавления новых элементов
    private var addElementTimer: AnyCancellable?
    // Таймер для проверки времени существования элементов
    private var printPositionTimer: AnyCancellable?
    // Время старта таймера
    private var timerStartTime: Date?
    
    // настройки размера таблицы
    let rows = 6
    let columns = 4
    let totalCells = (6 * 4)
    
    init(){
        simpleMoney = money ?? 0
    }
    
    //MARK: - Victory game
    func victoryGame(){
        stopTimers()
        gameVictory = true
        
        simpleMoney += moneyBattleField
        money = simpleMoney
        if (0...20) .contains(healthBattleField){
            simpleCrore = 1
        }
        if (20...70) .contains(healthBattleField){
            simpleCrore = 2
        }
        if healthBattleField > 70 {
            simpleCrore = 3
        }
    }
    
    //MARK: - Restart game function
    func restartGame(timertime: Double){
        stopTimers()
        healthBattleField = 100
        moneyBattleField = 0
        gameOver = false
        gameVictory = false
        isPauseview = false
        elements.removeAll()
        startTimers(with: timertime)
    }
    //MARK: - Add demage health
    func demadge(hero: GridElement){
        
        var getDemedge = false
        switch hero.hero{
        case .monster1:
            getDemedge = true
            SoundManager.instance.playSound(sound: .damage)
        case .monster2:
            getDemedge = true
            SoundManager.instance.playSound(sound: .damage)
        case .monster3:
            getDemedge = true
            SoundManager.instance.playSound(sound: .damage)
        case .monster4:
            getDemedge = true
            SoundManager.instance.playSound(sound: .damage)
        case .pirat1:
            getDemedge = true
            SoundManager.instance.playSound(sound: .damage)
        case .pirat2:
            getDemedge = true
            SoundManager.instance.playSound(sound: .damage)
        case .pirat3:
            getDemedge = true
            SoundManager.instance.playSound(sound: .damage)
        case .admiral:
            getDemedge = false
        case .jewerly1:
            getDemedge = false
        case .jewerly2:
            getDemedge = false
        case .jewerly3:
            getDemedge = false
        case .bomb:
            getDemedge = false
            SoundManager.instance.playSound(sound: .bomb)
        }
        if getDemedge{
            healthBattleField -= 1
            if healthBattleField <= 0 {
                stopTimers()
                healthBattleField = 0
                gameOver = true
                print("gameover: \(gameOver)")
            }
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
    func startTimers(with duration: Double) {
        maxTimerDuration = duration
        startElementAdditionTimer()
        startPositionPrintingTimer()
    }
    
    // Функция для паузы/возобновления игры
    func togglePause() {
        isPaused.toggle()
        isPauseview.toggle()
        
        if isPaused {
            // Приостановка: сохраняем время, прошедшее до паузы
            if let startTime = timerStartTime {
                elapsedBeforePause += Date().timeIntervalSince(startTime)
            }
            stopTimers() // Останавливаем все таймеры
        } else {
            // Возобновляем: пересчитываем оставшееся время и перезапускаем таймеры
            timerStartTime = Date()
            startElementAdditionTimer()
            startPositionPrintingTimer()
        }
    }
    
    // Таймер для добавления новых элементов
    private func startElementAdditionTimer() {
        timerStartTime = Date()  // Запоминаем время старта
        addElementTimer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                // Текущее время
                let currentTime = Date()
                
                // Общее время работы таймера
                if let startTime = self.timerStartTime {
                    let elapsedTime = currentTime.timeIntervalSince(startTime) + self.elapsedBeforePause
                    
                    // Обновляем оставшееся время
                    self.remainingTime = self.maxTimerDuration - elapsedTime
                    
                    // Проверяем, если время истекло
                    if self.remainingTime <= 0 {
                        print("Таймер добавления остановлен через \(self.maxTimerDuration) секунд.")
                        self.stopElementAdditionTimer()
                        self.victoryGame()
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
                demadge(hero: element)
                print("health \(healthBattleField) ")
            }
        }
    }
    // Остановка таймера добавления новых элементов
    private func stopElementAdditionTimer() {
        addElementTimer?.cancel()
        addElementTimer = nil
        remainingTime = 0 // Сбрасываем оставшееся время при остановке
    }
    
    // Функция для остановки всех таймеров
    func stopTimers() {
        addElementTimer?.cancel()
        printPositionTimer?.cancel()
    }
}
