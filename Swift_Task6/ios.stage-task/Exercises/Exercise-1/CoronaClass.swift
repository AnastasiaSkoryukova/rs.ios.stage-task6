import Foundation

class CoronaClass {
    
    var seats = [Int]()
    var freeSeats = [Int]()
    var number = 0
    
    var count = 0
    
    init(n: Int) {
        
        guard n-1 >= 0, n >= 1, n <= 100 else { return }
        
        self.freeSeats = Array(0...n-1)
    }
    
    func seat() -> Int {
        var currentDistance = 0
        var indecesArray = [Int]()
        
        guard !freeSeats.isEmpty else { return -1}
        
        if self.seats.isEmpty {
            seats.append(freeSeats.first!)
            if freeSeats.count > 2 {
            freeSeats = freeSeats.filter{$0 != freeSeats.first}
            }
            return freeSeats.first!
        } else if self.seats.count == 1 {
            seats.append(freeSeats.last!)
            if freeSeats.count > 2 {
            freeSeats = freeSeats.filter{$0 != freeSeats.last}
            }
            return freeSeats.last!
        }
        
                for i in 0...freeSeats.count - 1  {
                    for num in freeSeats {
                   let distance = num - freeSeats[i]
                    if distance > currentDistance{
                        currentDistance = distance
                        let index = (num - freeSeats[i]) / 2
                        indecesArray.append(index)
                    }
                }
                }
        

        
        guard let minimumIndex = indecesArray.min() else { return -1}
        
        
        self.number = freeSeats[minimumIndex]
        seats.append(number)
        freeSeats = freeSeats.filter{$0 != freeSeats[minimumIndex]}
        seats.sort { $0 < $1 }
        return number
    }
    
    
    
    
    func leave(_ p: Int) {
        if let index = seats.firstIndex(of: p) {
            seats.remove(at: index)
        }
        freeSeats.append(p)
        freeSeats.sort { $0 < $1 }
    }
}
