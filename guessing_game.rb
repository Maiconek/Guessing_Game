def game()
    target = rand(1..100)
    game_over = false

    while !game_over
        puts "Podaj liczbe"
        input = gets
        if input == "koniec\n"
            puts "żegnaj"
            break
        elsif input.to_i > target
            puts "za duża"
        elsif input.to_i < target
            puts "za mała"
        else
            puts "Brawo zgadłeś"
            game_over = true
        end
    end
end

puts "Teraz będziesz zgadywał liczbe"
game()

end_program = false
while !end_program
    puts "Czy gramy jeszcze raz? (Y/N)"

    choice = gets

    if choice == "Y\n"
        game()
    elsif choice =="N\n"
        puts "Koniec działania programu"
        end_program = true
    else
        puts "Nie ma takiej opcji mordo"
    end
end