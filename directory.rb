# Let's put all students into an array
students = [
  {name: "Dr. Hannibal Lecter", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "Darth Vader", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "Nurse Ratched", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "Michael Corleone", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "Alex DeLarge", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "The Wicked Witch of the West", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "Terminator", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "Freddy Krueger", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "The Joker", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "Joffrey Baratheon", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november},
  {name: "Norman Bates", height: "6\'0\"", hobbies: "Cricket, Basketball", country_of_birth: "Jamaica", cohort: :november}
]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is no empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains' Academy"
  puts "-----------"
end

def print(students)
  students.each_with_index do |student, number|
    if student[:name].downcase[0] == "t" && student[:name].length < 12
      puts "#{number+1}. #{student[:name]}, Height: #{student[:height]}, Country of birth: #{student[:country_of_birth]}, Hobbies: #{student[:hobbies]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
#nothing happens until we call the methods
#students = input_students
print_header
print(students)
print_footer(students)
