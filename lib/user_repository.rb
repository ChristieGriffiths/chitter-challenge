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

  def create(user)
    sql = 'INSERT INTO users (username, email_address) VALUES($1, $2)'
    result_set = DatabaseConnection.exec_params(sql, [user.username, user.email_address])
  end 

end 