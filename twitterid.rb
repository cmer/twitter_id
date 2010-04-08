require 'rubygems'
require 'sinatra'
require 'haml'
require 'ruby-debug'
get '/' do
  haml :welcome, :locals => {:username => ""}
end

post '/' do
  userid = user2id(params[:username])
  haml :welcome, :locals => {:username => params[:username], :userid => userid}
end

def user2id(username)
  begin
    output = `curl http://twitter.com/#{username} 2> /dev/null`
    userid = output.match(/user_timeline\/(([0-9])*)\.rss/)
    return userid[1]
  rescue
    nil
  end
end