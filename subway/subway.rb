require 'rspec'

class SubwayManager
  attr_accessor :network
  attr_accessor :start_station
  attr_accessor :stop_station
  attr_accessor :start_train
  attr_accessor :stop_train

  def initialize()
    n = ['ts', '34th', '28th-n', '23rd-n', 'us']
    l = ['8th', '6th', 'us', '3rd', '1st']
    s = ['gc', '33rd', '28th-s', '23rd-s', 'us']
    @network = {}
    @network[:n] = n
    @network[:l] = l
    @network[:s] = s
  end

  #Bonus method: find train from their station
  def which_train(station)
    i = 0
    while i < 5
      line = :n if @network[:n][i] == station 
      line = :s if @network[:s][i] == station 
      line = :l if @network[:l][i] == station 
      i += 1
    end
    return line
  end

  def menu
    puts "Which station are you at?"
    @start_station = gets.chomp.downcase
    @start_train = which_train(start_station)

    puts "Which station do you want to get to?"
    @stop_station = gets.chomp.downcase
    @stop_train = which_train(stop_station)
    
    travel_plan = {
    :start_station => start_station,
    :start_train => start_train,
    :stop_station => stop_station,
    :stop_train => stop_train
    }  
  end 

  def travel_distance(travel_plan)          
    if start_station == stop_station
      puts "\nYou're already here!"  

    elsif start_station == 'us' 
      index = @network[stop_train].index(stop_station) - network[stop_train].index('us')      
      index = index.abs
      puts "\nTake #{stop_train} train from 'us' to #{stop_station}."

    elsif stop_station == 'us' 
      index = network[start_train].index(start_station) - network[start_train].index('us')
      index = index.abs
      puts "\nTake #{stop_train} train to 'us'"

    elsif start_train == stop_train
      index1 = network[start_train].index(start_station) 
      index2 = network[stop_train].index(stop_station) 
      index = (index1 - index2).abs  
      puts "\nTake #{start_train} train to #{stop_station}" 

    elsif start_train != stop_train
      index1 = network[start_train].index(start_station) 
      index2 = network[start_train].index('us') 
      index3 = network[stop_train].index('us') 
      index4 = network[stop_train].index(stop_station)
      index = (index1 - index2).abs + (index3 - index4).abs 
      puts "\nTake #{start_train} train to 'us' then #{stop_train} train to '#{stop_station}' station."   

    return index #for rspec check
    end
  end


  def help
    travel_plan = menu
    total_length_of_trip = travel_distance(travel_plan)
    if total_length_of_trip != 0 || total_length_of_trip != nil
      puts "\nYour trip length is #{total_length_of_trip} stop(s)."
    end  
  end

end # SubwayManager ends

newsub = SubwayManager.new

puts "Take a look at the map: #{newsub.network}"
newsub.help
