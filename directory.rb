@students = []
$cohorts = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
$line_width = 100
$column_width = 20
$options = [:name, :height, :hobbies, :country_of_birth, :cohort]

def input_instructions
  puts "Please enter the details of the students:"
end

def ensure_valid_name(input)
  while input == ""
    puts "You must enter a name" 
    print "> "
    input = STDIN.gets.chomp
  end
  return input
end

def ensure_valid_cohort(input)
  while !($cohorts.include?(input.downcase))
    if input == ""
      return input = :november
    else
      print "That's not a month of the year!"
      puts " What is the student's cohort?"
      print "> "
      input = STDIN.gets.chomp
    end
  end
  return input
end

def build_student(saved_data, &user_input_block)
  block = (user_input_block || Proc.new { |a| })
  @student = {}
  $options.each_index do |x|
    input = block.call($options[x])
    input ||= saved_data[x]
    option_data_validity_checks(x, input)
  end
  @students << @student
end

def option_data_validity_checks(index, input)
  if $options[index] == :name
    name = ensure_valid_name(input)
    @student[:name] = name
  elsif $options[index] == :cohort
    cohort = ensure_valid_cohort(input)
    @student[:cohort] = cohort.downcase.to_sym
  else
    @student[$options[index]] = input
  end
end

def input_students
  input_instructions
  loop do
    build_student([], &$get_user_input)
    puts "Would you like to enter another student?"; print "> "
    return @students if STDIN.gets.chomp.downcase == "no"
  end
end

$get_user_input = Proc.new do |x|
  prompt_for_information_on(x)
  input = STDIN.gets.chomp
end

def prompt_for_information_on(option)
  if option.to_s.chars.last == "s"
    puts "What are the student's #{option.to_s.gsub(/_/, " ")}?"
  else
    puts "What is the student's #{option.to_s.gsub(/_/, " ")}?"
  end
  print "> "
end

def print_students
  @students.each do |student|
    student.each_value do |v| 
      print v.to_s.ljust($column_width)
    end
    print "\n"
  end
end

def print_student_list_by_cohort
  cohorts = @students.map{ |x| x[:cohort] }.uniq
  cohorts.each do |cohort|
    @students.each do |student|
      if student[:cohort] == cohort
        student.each_value do |v|
          print v.to_s.ljust($column_width)
        end
        print "\n"
      end
    end
  end
end

def print_menu
  puts "What do you want to do?"
  print "'1': input student details."
  puts "'2': display existing student details."
  print "'3': save student details."
  print "'4': load student details from students.csv."
  puts "'9': exit the program."
  print "> "
end

def print_header
  puts "The students of Villains Academy".upcase.center($line_width)
  puts ""
  $options.each { |option| print option.to_s.capitalize.ljust($column_width)}
  print "\n"
  print ("-" * $line_width)
  print "\n"
end

def print_footer
  puts ("-" * $line_width)
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student".center($line_width)
  else
    puts "Overall, we have #{@students.count} great students".center($line_width)
  end
end

def show_students
  unless @students == []
    print_header
    #print_student_list_by_cohort
    print_students
    print_footer
  else
    puts "There are no student details on the system at present."
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = []
    student.each_value { |v| student_data << v }
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end
$options.count.times do |i|
  
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    array = line.chomp.split(",")
    build_student(array)
  end
  file.close
end

def load_students_on_startup
  filename = ARGV.first
  if filename.nil?
    if File.exists?("students.csv")
      load_students("students.csv")
      puts "Loaded #{@students.count} students from 'students.csv'."
    end
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}."
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    @students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again."
  end
end

load_students_on_startup
interactive_menu

#    if student[:name].downcase[0] == "t" && student[:name].length < 12
