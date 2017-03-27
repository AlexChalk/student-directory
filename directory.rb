def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return when asked for a name"
  puts "To ignore a value, just hit return"
  # create an empty array
  students = []
  loop do
    $options.each do |option|
      prompt_for_information_on(option)
      input = gets.delete("\n")
      return students if option == :name && input == ""
      if option == :name
        students << {name: input}
      elsif option == :cohort
        students.last[option] = input.downcase.to_sym
        students.last[option] = :november if students.last[option] == :""
      else
        students.last[option] = input
      end
    end
    students
  end
end

#def print_students(students)
#  students.each do |student|
#    student.each_value do |v|
#      print v.to_s.ljust($column_width)
#    end
#    print "\n"
#  end
#end

def print_by_cohort(students)
  cohorts = students.map{ |x| x[:cohort] }.uniq
  cohorts.each do |cohort|
    students.each do |student|
      if student[:cohort] == cohort
        student.each_value do |v|
          print v.to_s.ljust($column_width)
        end
        print "\n"
      end
    end
  end
end

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
  $options.each { |option| print option.to_s.ljust($column_width)}
  print "\n"
end

def print_footer(names)
  puts "-----------".center($line_width)
  if names.count == 1
    puts "Overall, we have #{names.count} great student".center($line_width)
  else
    puts "Overall, we have #{names.count} great students".center($line_width)
  end
end

def prompt_for_information_on(option)
  if option.to_s.chars.last == "s"
    puts "What are the student's #{option.to_s.gsub(/_/, " ")}?"
  else
    puts "What is the student's #{option.to_s.gsub(/_/, " ")}?"
  end
end


$line_width = 110
$column_width = 20
$options = [:name, :height, :hobbies, :country_of_birth, :cohort]
students = input_students
print_header
print_by_cohort(students)
#print_students(students)
print_footer(students)


#    if student[:name].downcase[0] == "t" && student[:name].length < 12
