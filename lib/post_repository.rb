require 'post'

class PostRepository
  def all
    posts = []

    sql = 'SELECT id, peep, time_of_peep, user_id FROM posts'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.peep = record['peep']
      post.time_of_peep = record['time_of_peep']
      post.user_id = record['user_id']
      posts << post 
    end
    return posts 
  end 

  def create(post)
    sql = 'INSERT INTO posts (peep) VALUES ($1)'
    result_set = DatabaseConnection.exec_params(sql, [post.peep])
  end 
  
end