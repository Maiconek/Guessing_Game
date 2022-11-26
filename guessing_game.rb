#Guessing Game
# Punkt 1 - done
# Punkt 2 - done
# Punkt 3 - done
# Punkt 4 - done
# Punkt 5 - in progress
# Punkt 6 - not done
# Punkt 7 - not done
# Punkt 8 - not done

require 'date'

$gracz = Struct.new(:name, :counter, :number_to_guess, :date)

def saveResults(gracz)
    File.open("hallOfFame.txt", 'a') do |f|
        f.write "#{gracz[:name]}, #{gracz[:counter]}, #{gracz[:number_to_guess]}, #{gracz[:date]}\n"
    end
end

def extractPlayers()
    hall_of_fame = []

    if(File.file?('hallOfFame.txt'))
        File.foreach("hallOfFame.txt") { |each_line|  
            arr = each_line.split(",")
            hall_of_fame.push($gracz.new(arr[0], arr[1], arr[2], arr[3]))
        }
    end

    #hall_of_fame = hall_of_fame.sort {|a,b| a[:counter] <=> b[:counter]}
    puts hall_of_fame.sort {|a,b| a[:counter] <=> b[:counter]}
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
        extractPlayers
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

    player = $gracz.new(names.strip, counter, target, Time.now)

    saveResults(player)

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