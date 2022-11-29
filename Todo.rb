require "date"

class Todo
  def initialize(text,duedate,completed)
    @text = text
    @due_date = duedate
    @completed = completed
  end

  def to_displayable_string
    display_status = @completed ? "[X]" : "[ ]"
    display_date = duetoday? ? nil : @due_date
    "#{display_status} #{@text} #{display_date}"
  end

  def overdue?
    @due_date < Date.today
  end

  def duetoday?
    @due_date == Date.today
  end

  def duelater?
    @due_date > Date.today
  end

end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.duetoday? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.duelater? })
  end

  def add(todos)
    @todos.push(todos)
  end


  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]


todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"