require 'rainbow/ext/string'

class SubwayManager

  def initialize()

    n = ['ts', '34th', '28th-n', '23rd-n', 'us']
    l = ['8th', '6th', 'us', '3rd', '1st']
    s = ['gc', '33rd', '28th-s', '23rd-s', 'us']

    @network = {}

    @network[:n] = n
    @network[:l] = l
    @network[:s] = s

  end

  def menu

    travel_plan = {}

    puts `clear`
    puts "***network***".color('#0033ff')
    print "\nWhat train do you want to get on: #{network.keys.join(', ')}? ".color('#ff3300')
    travel_plan[:start_train] = gets.chomp.to_sym

    print "Which stop: #{network[start_train].join(', ')}? ".color('#ff3300')
    travel_plan[:start_station] = gets.chomp

    print "\nWhat train do you want to get off: #{network.keys.join(', ')}? ".color('#ff0033')
    travel_plan[:stop_train] = gets.chomp.to_sym
    print "Which stop: #{@network[stop_train].join(', ')}? ".color('#ff0033')
    travel_plan[:stop_station] = gets.chomp

    return travel_plan

  end

  def travel_distance(travel_plan)

    if travel_plan[:start_train] != travel_plan[:stop_train]
      intersection = (@network[travel_plan[:start_train]] & @network[travel_plan[:stop_train]]).first
      # intersection = 'us'

      stop_a_index = @network[travel_plan[:start_train]].index(travel_plan[:start_station])
      stop_a_intersection_index = @network[travel_plan[:start_train]].index(intersection)
      trip_a_length = (stop_a_index - stop_a_intersection_index).abs

      stop_b_index = @network[travel_plan[:stop_train]].index(travel_plan[:stop_station])
      stop_b_intersection_index = @network[travel_plan[:stop_train]].index(intersection)
      trip_b_length = (stop_b_index - stop_b_intersection_index).abs

      total_length_of_trip = trip_a_length + trip_b_length
    else
      stop_a_index = @network[travel_plan[:start_train]].index(travel_plan[:start_station])
      stop_b_index = @network[travel_plan[:stop_train]].index(travel_plan[:stop_station])
      total_length_of_trip = (stop_a_index - stop_b_index).abs
    end

    total_length_of_trip
  end

  def help
    travel_plan = menu
    total_length_of_trip = travel_distance(travel_plan)
    puts "\n\nYour trip length is #{total_length_of_trip} stops.\n\n".color('#ff9900')
  end

end


newsub = SubwayManager.new
newsub.help