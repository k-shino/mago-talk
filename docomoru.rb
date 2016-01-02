require "docomoru/client"
require "docomoru/command_builder"
require "docomoru/version"
require "rubygems"
require "sinatra"
require "sinatra/reloader"

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/' do
	client = Docomoru::Client.new(api_key: "376f5479654d35514574463155363475396c4d6661694f6866576e556c487a5a7669356b394a795068472f")
	response = client.create_dialogue("明けましておめでとう")
    @title = "title"
	@body = ""
	erb :index
end


post '/' do
	client = Docomoru::Client.new(api_key: "376f5479654d35514574463155363475396c4d6661694f6866576e556c487a5a7669356b394a795068472f")
	response = client.create_dialogue(params[:name])
    @body = response.body
    erb :index
#  erb %{
#    <p>こんにちは，<%= h params[:name] %>さん！</p>
#    <a href='/'>戻る</a>
#  }
end

