#Guessing Game
# Punkt 1 - done
# Punkt 2 - done
# Punkt 3 - done
# Punkt 4 - done
# Punkt 5 - not done
# Punkt 6 - not done
# Punkt 7 - not done
# Punkt 8 - not done

require 'date'

$results = Hash.new

def saveResults(names, counter)
    $results[names] = counter
end

def printResults()
    #puts $results.sort_by{ |key, value| value }
    
    scoreboard = $results.sort_by{ |key, value| value }
    
    scoreboard.each do |key, value|
        puts "Gracz #{key} odgadł prawidłową liczbe w #{value} krokach"
    end
end

def saveToTextFile(names, counter)
    current_datetime = DateTime.now

    File.open('hallOfFame.txt', 'a') do |f|
        #f.write "Gracz #{names} odgadł prawidłową liczbe w #{counter} krokach  w dniu #{current_datetime}"
        f.write "#{names}, #{counter}, #{current_datetime}\n" 
    end
end

def menu()
    puts "Witamy w Guessing Game"
    puts "1. Zagraj"
    puts "2. Zobacz ostatnie wyniki"

    option = gets

    case option.to_i
    when 1
        game()
    when 2
        printResults()
        menu()
    else
        puts "Nie ma takiej opcji"    
    end
end


def game()
    target = rand(1..100)
    game_over = false
    counter = 0    
    
    puts "Teraz będziesz zgadywał liczbe"
        while !game_over
            puts "Podaj liczbe"
            input = gets
            counter += 1

            if input == "koniec\n"
                puts "żegnaj"
                exit
            elsif input.to_i > target
                puts "za duża"
            elsif input.to_i < target
                puts "za mała"
            else
                puts "Brawo zgadłeś"
                game_over = true
            end
        end
    
    puts "Podaj swoje imie i nazwisko, abyśmy mogli zapisać twój wynik"
    names = gets

    saveResults(names.strip, counter)
    saveToTextFile(names.strip, counter)

    playAgain()
end


def playAgain()
    puts "Czy gramy jeszcze raz? (Y/N)"

    choice = gets

    if choice.upcase == "Y\n"
        menu()
    elsif choice.upcase =="N\n"
        puts "Koniec działania programu"
        exit
    else
        puts "Nie ma takiej opcji mordo"
    end    
end
    

menu()