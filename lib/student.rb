class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id #if id != nil
  end 
  
  def self.create_table
    sql = DB[:conn].execute("CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)")
  end 

  def self.drop_table
    sql = DB[:conn].execute("DROP TABLE students")
  end 

  def save 
    # using SQL query from the lesson
    sql = <<-SQL
    INSERT INTO students (name, grade) 
    VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

    # using only SQL statment but why it does not work?
    # DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)")
    # @id = DB[:conn].execute("SELECT * FROM students ORDER BY students.id DESC LIMIT 1")
  end 

  # using proper metaprogramming. play with it more to gain understanding!
  # def self.create(attributes)
  #     binding.pry
  #     #student = Student.new(attributes)
  #     result = attributes.each {|key, value| self.send(("#{key}="),value)}
  #     puts "#{result}"
  #     student.save
  #     student
  # end

      
    def self.create(name:, grade:)
      student = Student.new(name, grade)
      student.save
      student
    end

end
