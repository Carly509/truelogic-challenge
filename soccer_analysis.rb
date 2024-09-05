begin
  file_path = File.join('data', 'soccer.dat')
  data = File.readlines(file_path).drop(1) # Skip the header line

  smallest_difference = Float::INFINITY
  team_with_smallest_difference = nil
  goals_for = 0
  goals_against = 0

  data.each do |line|
    # Split the line and extract relevant data
    columns = line.split
    next if columns.length < 10 # Skip lines that don't have enough columns

    team_name = columns[1]
    team_goals_for = columns[6].to_i
    team_goals_against = columns[8].to_i

    # Calculate goal difference
    difference = (team_goals_for - team_goals_against).abs

    # Update if this is the smallest difference so far
    if difference < smallest_difference
      smallest_difference = difference
      team_with_smallest_difference = team_name
      goals_for = team_goals_for
      goals_against = team_goals_against
    end
  end

  if team_with_smallest_difference
    puts "Team with smallest goal difference: `#{team_with_smallest_difference}`."
    puts "Goals for: #{goals_for}, Goals against: #{goals_against}, Difference: #{smallest_difference}"
  else
    puts "No valid data found in the file."
  end
rescue Errno::ENOENT
  puts "Error: File '#{file_path}' not found."
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
end
