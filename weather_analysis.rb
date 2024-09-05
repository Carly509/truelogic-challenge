def find_day_with_smallest_spread(file_path)
  smallest_spread = Float::INFINITY
  result_day = nil

  File.foreach(file_path).with_index do |line, index|
    next if index < 2  # Skip the first two header lines

    columns = line.split
    next if columns.length < 3 || columns[0] == 'mo'  # Skip invalid lines and monthly summary

    day = columns[0].to_i
    max_temp = columns[1].to_f
    min_temp = columns[2].to_f

    next if day == 0 || max_temp == 0 || min_temp == 0  # Skip lines with invalid data

    spread = max_temp - min_temp

    if spread < smallest_spread
      smallest_spread = spread
      result_day = day
    end
  end

  [result_day, smallest_spread]
end

file_path = 'data/w_data.dat'

begin
  day, spread = find_day_with_smallest_spread(file_path)

  if day
    puts "Day with smallest temperature spread: #{day}"
    puts "Temperature spread: #{spread.round(1)} degrees"
  else
    puts "No valid data found in the file."
  end
rescue Errno::ENOENT
  puts "Error: File '#{file_path}' not found."
end
