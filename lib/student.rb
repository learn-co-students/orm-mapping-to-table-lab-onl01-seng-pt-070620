class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
  end 
  
  def self.create_table
    sql = DB[:conn].execute("CREATE TABLE students (id PRIMARY KEY, name TEXT, grade INTEGER)")
  end 

  def self.drop_table
    sql = DB[:conn].execute("DROP TABLE students")
  end 

  def save 
    # using SQL query from the lessoon
    sql = <<-SQL
    INSERT INTO students (name, grade) 
    VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

    # DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)")
    # @id = DB[:conn].execute("SELECT * FROM students ORDER BY ID DESC LIMIT 1")
  end 

   
  def self.create(student)
      student = Students.new(name, album)
      student.each {|key, value| send("#{key}=",value)}
        end 
      student.save
      student
  end


end
