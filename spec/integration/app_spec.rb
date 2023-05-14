require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do 

  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods 

  # We need to declare the 'app' value by 
  # instanstiation the class so our test work. 
  let(:app) { Application.new }

  def reset_user_and_post_tables
    seed_sql = File.read('spec/seeds/chitter_test_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_testing_database' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_user_and_post_tables
  end 

  context '/' do
    it "returns the login/sign up" do 
      response = get("/")
      expect(response.status).to eq (200)
      expect(response.body).to include ('<p>CHITTER</p>')
      expect(response.body).to include ("https://www.dropbox.com/s/0cekdy9bp3nc84z/pexels-elizabeth-tr-armstrong-680230.jpg?raw=1")
    end 
  end 

  context '/home' do
    it "returns the home page" do 
      response = get("/home")
      expect(response.status).to eq (200)
      expect(response.body).to include ('Peep')
      # expect(response.body).to include ('Sort by date')
      # expect(response.body).to include ('Log out')
    end 
  end

  context 'POST /home' do
    it "should create a post, save it to the database, and return chitter homepage now displaying that tweet" do
      response = post('/home', peep: "Woke up this morning in the desert heat")
      expect(response.status).to eq (200)
      expect(response.body).to include ("Woke up this morning in the desert heat")
      expect(response.body).to include ("Pixie")
    end

    it "should create a post, save it to the database, and return chitter homepage now displaying that tweet" do
      response = post('/home', peep: "Went to bed at 6pm, again!")
      expect(response.status).to eq (200)
      expect(response.body).to include ("Went to bed at 6pm, again!")
      expect(response.body).to include ("Pixie")
    end
  end

  context 'GET /login' do
    it 'gives user a login page' do
      response = get('/login')
      expect(response.status).to eq (200)
      expect(response.body).to include ("Username:")
      expect(response.body).to include ("Password:")
    end
  end

  context 'GET /signup' do
    it 'gives user a sign up page' do
      response = get('/signup')
      expect(response.status).to eq (200)
      expect(response.body).to include ("Username:")
      expect(response.body).to include ("Email Address:")
      expect(response.body).to include ("Password:")
    end
  end

  context 'POST /login' do
    it 'if account info is correct sends user to home page' do
      response = post('/login', username: "Pixie", password: "porridge1998")
      expect(response.status).to eq (200)
      expect(response.body).to include ("Peep:")
    end
  end

  context 'POST /signup' do
    it 'gives user a sign up page' do
      response = post('/signup', username: "Jurgen", email_address: "klopp@hotmail.com", password: "blackforest")
      expect(response.status).to eq (200)
      expect(response.body).to include ("Username:")
      expect(response.body).to include ("Password:")
    end
  end

      
  #   end
  # end

  # context '' do
  #   it '' do
      
  #   end
  # end

end 
