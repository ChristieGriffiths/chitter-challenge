require 'user'
require 'user_repository'

def reset_user_table
  seed_sql = File.read('spec/seeds/chitter_test_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_testing_database' })
  connection.exec(seed_sql)
end

describe UserRepository do 
  before(:each) do
    reset_user_table
  end 

  it "finds all users" do
    repo = UserRepository.new
    users = repo.all 
    expect(users.length).to eq (3)
    expect(users.first.email_address).to eq ("dust@gmail.com")
  end

  it "finds a user by id" do 
    repo = UserRepository.new 
    user = repo.find(1)
    expect(user.username).to eq ("Pixie")
  end 

  it "finds a user by username" do 
    repo = UserRepository.new
    user = repo.find_user("Pixie")
    expect(user.password).to eq ("porridge1998")
    expect(user.username).to eq ("Pixie")
  end 

  it "creates a user" do 
    repo = UserRepository.new 
    user = User.new 
    user.username = "Danny"
    user.email_address = "Dannybenz@gmail.com"
    user.password = "Muesli"
    repo.create(user)
    
    users = repo.all 
    expect(users.length).to eq (4)

    expect(users.last.username).to eq ("Danny")
    expect(users.last.email_address).to eq ("Dannybenz@gmail.com")
  end 
    
end
