# Author => Marcin Baranowski

# Guessing Game
# Punkt 1 - done
# Punkt 2 - done
# Punkt 3 - done
# Punkt 4 - done
# Punkt 5 - done
# Punkt 6 - not done
# Punkt 7 - not done
# Punkt 8 - not done

require 'date'
require 'colorize'

String.disable_colorization = false

$gracz = Struct.new(:name, :counter, :number_to_guess, :date)

def saveResults(gracz)
    File.open("hallOfFame.txt", 'a') do |f|
        f.write "#{gracz[:name]},#{gracz[:counter]},#{gracz[:number_to_guess]},#{gracz[:date]}\n"
    end
end

def extractPlayers()
    hall_of_fame = []

    if(File.file?('hallOfFame.txt'))
        File.foreach("hallOfFame.txt") { |each_line|  
            arr = each_line.split(",")
            hall_of_fame.push($gracz.new(arr[0], arr[1].to_i, arr[2].to_i, arr[3]))
        }
    end

    sorted_hall_of_fame = hall_of_fame.sort_by(&:counter)
    return sorted_hall_of_fame
end

def printResults()
    results = extractPlayers()
    position = 1
    puts "%-2s %-24s %-15s %-18s".light_yellow % ["Nr", "Nickname", "Ilość prób", "Wylosowana liczba"]
    results.each { |p|
        if results.index(p) % 2 == 0
            puts "%-2d %-24s %-15d %-17d".colorize(:color => :light_white, :background => :blue) % [position, p.name, p.counter, p.number_to_guess]    
        else
            puts "%-2d %-24s %-15d %-17d".colorize(:color => :light_white) % [position, p.name, p.counter, p.number_to_guess]
        end
        position += 1
    }
end

def stats()
    hall_of_fame = extractPlayers()
    sum = 0.0
    divider = 0.0
    numbers = []
    results = []

    hall_of_fame.each { |p|
            results.append(p.counter)
            numbers.append(p.number_to_guess)
            sum += p.counter
            divider += 1.0
    }

    average = sum / divider
    puts "\nŚrednia ilość prób do odgadnięcia ukrytej liczby => #{average.to_f}".light_white
    puts "Najmniej prób przed zgadnięciem liczby => #{results.min}".light_cyan
    puts "Najwięcej prób przed zgadnięciem liczby => #{results.max}".light_green
    puts "Najmniejsza zgadnięta liczba => #{numbers.min}".light_yellow
    puts "Największa zgadnięta liczba => #{numbers.max}".light_red
    puts ""
end

def checkIfNewRecord(player)
    hall_of_fame = extractPlayers()
    results = []
    hall_of_fame.each { |p|
        results.append(p.counter)
    }

    puts results.min

    if player.counter < results.min
        puts "Właśnie ustanowileś nowy rekord w Guessing Game! Gratulacje".light_green
    end
end

def game()
    target = rand(1..100)
    game_over = false
    counter = 0  

    puts "Teraz będziesz zgadywał liczbe".light_cyan
    
    while !game_over
        puts "Podaj liczbe".light_white
        input = gets
        counter += 1

        if input == "koniec\n"
            puts "żegnaj".light_red
            exit
        elsif input.to_i > target
            puts "za duża".light_red
        elsif input.to_i < target
            puts "za mała".light_yellow
        else
            puts "Brawo zgadłeś".light_green
            game_over = true
        end
    end
    

    puts "Podaj swoje imie i nazwisko, abyśmy mogli zapisać twój wynik".light_blue
    names = gets

    player = $gracz.new(names.strip, counter, target, Time.now)

    checkIfNewRecord(player)
    saveResults(player)

    playAgain()
end


def playAgain()
    puts "Czy gramy jeszcze raz? (Y/N)".light_magenta

    choice = gets

    if choice.upcase == "Y\n"
        menu()
    elsif choice.upcase =="N\n"
        puts "Koniec działania programu".light_red
        exit
    else
        puts "Nie ma takiej opcji".light_yellow
    end    
end

def menu()
    begin
        puts "Witamy w Guessing Game".light_cyan
        puts "1. Zagraj".light_green
        puts "2. Zobacz ostatnie wyniki".light_yellow
        puts "3. Ciekawe statystki".light_magenta
        puts "4. Wyjdź z gry".light_red

        option = gets
    
        case option.to_i
        when 1
            game()
        when 2
            printResults
            menu()
        when 3
            stats()
            menu()
        when 4
            puts "papa".light_magenta
            exit
        else
            puts "Nie ma takiej opcji"    
        end
    rescue Interrupt => e
        puts "papa".light_magenta
    end   
end

 
menu()