@students = []
$cohorts = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december", ""]
$line_width = 110
$column_width = 20
$options = [:name, :height, :hobbies, :country_of_birth, :cohort]

def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return when asked for a name"
  puts "To ignore a value, just hit return"
  # create an empty array
  loop do
    $options.each do |option|
      prompt_for_information_on(option)
      input = gets.chomp
      return @students if option == :name && input == ""
      if option == :name
        @students << {name: input}
      elsif option == :cohort
        while !($cohorts.include?(input.downcase))
          puts "That's not a month of the year!"
          puts "What is the student's cohort?"
          input = gets.chomp
        end
        @students.last[option] = input.downcase.to_sym
        @students.last[option] = :november if @students.last[option] == :""
      else
        @students.last[option] = input
      end
    end
  end
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
  puts "Use '1' to input student details."
  puts "Use '2' to display all student details on the system."
  puts "Use '3' to save student details to students.csv."
  puts "Use '4' to load student details from students.csv."
  puts "Use '9' to exit the program."
end

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
  $options.each { |option| print option.to_s.ljust($column_width)}
  print "\n"
end

def print_footer
  puts "-----------".center($line_width)
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student".center($line_width)
  else
    puts "Overall, we have #{@students.count} great students".center($line_width)
  end
end

def prompt_for_information_on(option)
  if option.to_s.chars.last == "s"
    puts "What are the student's #{option.to_s.gsub(/_/, " ")}?"
  else
    puts "What is the student's #{option.to_s.gsub(/_/, " ")}?"
  end
end

def show_students
  unless @students == []
    print_header
    print_student_list_by_cohort
    #print_students
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

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    array = line.chomp.split(",")
    array.each_index do |x|
      if x == 0
        @students << {$options[x] => array[x]}
      elsif x == array.length-1
        @students.last[$options[x]] = array[x].to_sym
      else
        @students.last[$options[x]] = array[x]
      end
    end
  end
  file.close
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

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end
interactive_menu

#    if student[:name].downcase[0] == "t" && student[:name].length < 12
