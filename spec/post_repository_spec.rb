require 'post'
require 'post_repository'

def reset_post_table
  seed_sql = File.read('spec/seeds/chitter_test_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_testing_database' })
  connection.exec(seed_sql)
end

describe PostRepository do 
  before(:each) do
    reset_post_table
  end 

  it "finds all posts" do
    repo = PostRepository.new
    posts = repo.all 
    expect(posts.length).to eq (3)
    expect(posts.first.peep).to eq ("Just saw the queen")
  end

  it "creates a post" do 
    repo = PostRepository.new 
    post = Post.new 
    post.peep = "Lost my ways"
    post.user_id = "3"
    repo.create(post)
    
    posts = repo.all 
    expect(posts.length).to eq (4)
    expect(posts.last.peep).to eq ("Lost my ways")
    expect(posts.last.time_of_peep).to include ("2023")
  end 
    
end