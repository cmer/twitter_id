require 'rubygems'
require 'sinatra'
require 'haml'
require 'open-uri'
require 'json'

get '/' do
  haml :welcome, :locals => {:username => ""}
end

post '/' do
  userid = user2id(params[:username])
  haml :welcome, :locals => {:username => params[:username], :userid => userid}
end

def user2id(username)
  begin
    output = open("http://api.twitter.com/1/users/show.json?screen_name=#{username}").read
    h = JSON.load(output)
    h["id"]
  rescue
    nil
  end
end