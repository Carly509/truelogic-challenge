begin
  file_path = File.join('data', 'soccer.dat')
  data = File.readlines(file_path).drop(1) # Skip the header line

  smallest_difference = Float::INFINITY
  team_with_smallest_difference = nil
  goals_for = 0
  goals_against = 0

  data.each do |line|
    columns = line.split
    next if columns.length < 10 # Skip lines that don't have enough columns

    team_name = columns[1]
    team_goals_for = columns[6].to_i
    team_goals_against = columns[8].to_i

    difference = team_goals_for - team_goals_against

    if difference.abs < smallest_difference.abs
      smallest_difference = difference
      team_with_smallest_difference = team_name
      goals_for = team_goals_for
      goals_against = team_goals_against
    end
  end

  if team_with_smallest_difference
    puts "The team with the smallest goal difference is: `#{team_with_smallest_difference}`."
    puts "Goals for: #{goals_for}, Goals against: #{goals_against}, Difference: #{smallest_difference}"
  else
    puts "No valid data found in the file."
  end
rescue Errno::ENOENT
  puts "Error: File '#{file_path}' not found."
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
end
