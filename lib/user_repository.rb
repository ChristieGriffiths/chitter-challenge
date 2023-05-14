require_relative 'user'

class UserRepository

  def all
    users = []
    sql = 'SELECT id, username, email_address FROM users'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      user = User.new 
      user.id = record['id'].to_i
      user.username = record['username']
      user.email_address = record['email_address']
      users << user
    end
    return users
  end 

  def find(id)
    sql = 'SELECT id, username, email_address FROM users WHERE id = $1'
    result_set = DatabaseConnection.exec_params(sql, [id])
    result_set = result_set[0]
    user = User.new
    user.id = result_set["id"]
    user.username = result_set["username"]
    user.email_address = result_set["email_address"]
  
    return user
  end

  def find_user(username)
    sql = 'SELECT id, username, email_address, password FROM users WHERE username = $1'
    result_set = DatabaseConnection.exec_params(sql, [username])
    result_set = result_set[0]
    user = User.new
    user.id = result_set["id"]
    user.username = result_set["username"]
    user.email_address = result_set["email_address"]
    user.password = result_set["password"]
    return user
  end

  def create(user)
    sql = 'INSERT INTO users (username, email_address, password) VALUES($1, $2, $3)'
    result_set = DatabaseConnection.exec_params(sql, [user.username, user.email_address, user.password])
    
  end 
end 
