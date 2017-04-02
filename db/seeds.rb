puts 'create users'

ivan = User.create!(
  email: 'ivanivan@mail.ru',
  login: 'RubyCritic',
  password: 'ivanivan@mail.ru'
)
petr = User.create!(
  email: 'petrpetr@mail.ru',
  login: 'iLoveJavascript',
  password: 'petrpetr@mail.ru'
)
vova = User.create!(
  email: 'vovavova@mail.ru',
  login: 'differentUser',
  password: 'vovavova@mail.ru'
)

puts 'create gists'

# ivan has 12 ruby gists
ivan.gists.create!(
  title: 'hello.rb',
  lang_mode: 'ruby',
  body: 'puts("hello")'
)
ivan.gists.create!(
  title: 'user.rb',
  lang_mode: 'ruby',
  body: '#model
class User < ApplicationRecord # :nodoc:
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :gists, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :login, presence: true, length: { minimum: 3 }, uniqueness: true

  def guest?
    id.nil?
  end

  def not_guest?
    !guest?
  end
end'
)
ivan.gists.create!(
  title: 'application_controler.rb',
  lang_mode: 'ruby',
  body: "class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, with: :render_error

  def render_not_found
    if request.xhr?
      render json: { status: :not_found } and return
    else
      render template: 'errors/404', formats: :html, status: :not_found and return
    end
  end

  def render_error
    if request.xhr?
      render json: { status: :internal_server_error } and return
    else
      render template: 'errors/500', formats: :html, status: :internal_server_error and return
    end
  end
end"
)
ivan.gists.create!(
  title: 'home_controller.rb',
  lang_mode: 'ruby',
  body: 'class HomeController < ApplicationController # :nodoc:
  def main
    @gists = Gist.preload(:user).limit(10)
  end
end'
)
ivan.gists.create!(
  title: 'comment.rb',
  lang_mode: 'ruby',
  body: 'class Comment < ApplicationRecord
  default_scope -> { order(created_at: :asc) }

  belongs_to :user
  belongs_to :gist

  validates :body, presence: true
  validates :user_id, :user, presence: true
  validates :gist_id, :gist, presence: true
end'
)
ivan.gists.create!(
  title: 'yaml.rb',
  lang_mode: 'ruby',
  body: 'require "yaml"
class Ogre
  def initialize(strength, speed)
    @strength = strength
    @speed = speed
  end

  def self.deserialize(yaml_string)
    YAML::load(yaml_string)
  end

  def serialize
    YAML::dump(self)
  end

  # now we are free to define #to_s however we like!
  # ...which is great, because #to_s is for programmers to read,
  # not computers or users
  def to_s
    "Ogre: [strength = #{@strength}, speed = #{@speed}]"
  end
end'
)
ivan.gists.create!(
  title: 'rescue.rb',
  lang_mode: 'ruby',
  body: 'def zen
  10.times do
    answer = 42 / 0
  end
end
begin
  puts "Calling zen."
  zen
rescue ZeroDivisionError => error
  puts "Rescued from the zen method."
  puts error.backtrace
end
puts "End of main."'
)
ivan.gists.create!(
  title: 'time.rb',
  lang_mode: 'ruby',
  body: 't = Time.now
#=> 2011-08-03 22:35:01 -0600

t2 = t + 10               # 10 Seconds
#=> 2011-08-03 22:35:11 -0600

t3 = t + 10*60            # 10 minutes
#=> 2011-08-03 22:45:01 -0600

t4 = t + 10*60*60         # 10 hours
#=> 2011-08-04 08:35:01 -0600'
)
ivan.gists.create!(
  title: 'ruby_class.rb',
  lang_mode: 'ruby',
  body: 'class Language
  def initialize(name, creator)
    @name = name
    @creator = creator
  end

  def description
    puts "I am #{@name} and I was created by #{@creator}!"
  end
end

ruby = Language.new("Ruby", "Yukihiro Matsumoto")
python = Language.new("Python", "Guido van Rossum")
javascript = Language.new("JavaScript", "Brendan Eich")

ruby.description
python.description
javascript.description'
)
ivan.gists.create!(
  title: 'tweet.rb',
  lang_mode: 'ruby',
  body: 'class Tweet
  def initialize ( tweets )
    @tweets = tweets
  end
  def tweets
    @tweets
  end
  alias_method :contents, :tweets #comment
end'
)
ivan.gists.create!(
  title: 'tweet_2.rb',
  lang_mode: 'ruby',
  body: 'class Tweet
  attr_reader :status
  def initialize
    @status = "";
  end
  def draft
    @status = :draft
  end
  def posted
    @status = :posted
  end
  def delete
    @status = :delete
  end
end

# rewrite like
class Tweet
  attr_reader :status
  states = [ :draft, :posted, :delete]
  states.each do |status|
    define_method status do
      @status = status
    end
  end
end

tweet = Tweet.new
puts tweet.status
tweet.draft
puts tweet.status
tweet.posted
puts tweet.status
tweet.delete
puts tweet.status'
)
ivan.gists.create!(
  title: 'library.rb',
  lang_mode: 'ruby',
  body: 'class Library
  attr_accessor :games
  METHODES = [ :each, :map, :select ]
  METHODES.each do |method_name|
    define_method method_name do |&block|
      games.send(method_name, &block)
     end
  end
end'
)

# petr has 5 javascript gists
petr.gists.create!(
  title: 'productDiscount.js',
  lang_mode: 'javascript',
  body: "var productDiscount = {

  discountByTypes: {
    cheap: 0.20,
    expensive: 0.10
  },

  getDiscoutedPrice: function(price, discount) {
    return price - (price * discount);
  },

  getDiscountedByType: function(price, type) {
    return this.getDiscoutedPrice(price, this.discountByTypes[type]);
  },

  setPrice: function(elem, price, type) {
    var discountedPrice = this.getDiscountedByType(price, type);
    elem.html(discountedPrice);
  },

  init: function() {
    $('.products li').each(function() {
      var price = $(this).find('.price').html(),
        type = $(this).data('type');

      productDiscount.setPrice($(this).find('.price'), price, type);
    });
  }
}
productDiscount.init();"
)
petr.gists.create!(
  title: 'make_request.js',
  lang_mode: 'javascript',
  body: "var http = require('http');
const StringDecoder = require('string_decoder').StringDecoder;
const decoder = new StringDecoder('utf8');

var makeRequest = function(message){
  var options = {
    host: 'localhost',
    port: 8080,
    path: '/',
    method: 'POST'
  }

  var request = http.request(options, function(response){
    response.on('data', function(data){
      //decode message from buffer
      console.log(decoder.write(data));
    });
  });

  request.on('error', function(err) {
    console.log('we have an error!');
    console.log(err);
  });

  request.write(message);
  request.end();
}

//start request
makeRequest('Here is looking at you, kid!');"
)
petr.gists.create!(
  title: 'read_file.js',
  lang_mode: 'javascript',
  body: 'var content = fs.readFileSync("/etc/hosts");

// or
fs.readFile("/etc/hosts", function(err, contents){
  console.log( content );
});'
)
petr.gists.create!(
  title: 'file_uploader.js',
  lang_mode: 'javascript',
  body: 'http.createServer(function(request, response){
var newFile = fs.createWriteStream("new_file.md"),
  fileBytes = request.headers["content-length"],
  uploadedBytes = 0;

request.on("readable", function(){
  var chunk = null;
  while( null !== (chunk = request.read()) ){
    uploadedBytes += chunk.length;
    var progress = ( uploadedBytes / fileBytes ) * 100;
    response.write( "progress: " + parseInt(progress, 10) + "%\n" );
  }
});

request.pipe(newFile);

request.on("end", function(){
  response.end();
});
}).listen(8080);

//curl --upload-file file01.pdf http://localhost:8080/'
)
js_js_gist = petr.gists.create!(
  title: 'js.js',
  lang_mode: 'javascript',
  body: 'var todo_objects = {
  1: { description: "Pick up milk", status: "incomplete", id: 1},
  2: { description: "Pick up cereal", status: "complete", id: 2}
};
newId = Object.keys(todo_objects).length;
console.log( newId ); //2'
)

# vova has 5 gifferent gists
create_db_gist = vova.gists.create!(
  title: 'create_db',
  lang_mode: 'sql',
  body: 'CREATE DATABASE mybase01;'
)
vova.gists.create!(
  title: 'create_table',
  lang_mode: 'sql',
  body: 'create table users (
  users_id INT NOT NULL AUTO_INCREMENT,
  first_name char (20) NOT NULL,
  last_name char (20) NOT NULL,
    login char (20) NOT NULL,
    password char(20) NOT NULL,
  PRIMARY KEY (users_id)
);'
)
vova.gists.create!(
  title: 'select',
  lang_mode: 'sql',
  body: 'SELECT * FROM student WHERE age=21;
SELECT first_name, last_name FROM student WHERE age=21 AND study="IT";
SELECT * FROM student WHERE info is NULL;'
)
vova.gists.create!(
  title: 'alter_table',
  lang_mode: 'sql',
  body: 'alter table guitarwars DROP COLUMN age;
alter table guitarwars ADD COLUMN age INT first;
alter table guitarwars ADD COLUMN age INT after name;
alter table guitarwars CHANGE COLUMN score high_score INT;
alter table guitarwars MODIFY COLUMN date DATETIME AFTER age;
alter table guitarwars MODIFY COLUMN description CHAR (120);
ALTER TABLE my_contacts ADD COLUMN id int(3) auto_increment FIRST, ADD PRIMARY KEY (id);
ALTER TABLE contact RENAME TO my_contacts;'
)
select2_gist = vova.gists.create!(
  title: 'select2',
  lang_mode: 'sql',
  body: "SELECT * FROM PHOTO
  INNER JOIN PHOTO_COLOR
    ON PHOTO.ID=PHOTO_COLOR.PHOTO_FK
  INNER JOIN COLOR
    ON PHOTO_COLOR.ID=COLOR.ID
WHERE PHOTO.HASH='8fa358533b8da1dace87b4e6eed9e2e3'"
)

# comments
puts 'create comments'
create_db_gist.comments.create!(
  user_id: vova.id,
  body: 'test'
)
create_db_gist.comments.create!(
  user_id: vova.id,
  body: 'test 2'
)
select2_gist.comments.create!([
  {
    user_id: ivan.id,
    body: 'cool stuff!!! =)'
  },
  {
    user_id: petr.id,
    body: 'Yeah! reslly cool'
  },
  {
    user_id: vova.id,
    body: 'thank you 8)'
  }
])
js_js_gist.comments.create!([
  {
    user_id: ivan.id,
    body: '1'
  },
  {
    user_id: petr.id,
    body: '2'
  },
  {
    user_id: ivan.id,
    body: '3'
  },
  {
    user_id: petr.id,
    body: '4'
  },
  {
    user_id: ivan.id,
    body: '5'
  },
  {
    user_id: petr.id,
    body: '6'
  }
])