require "docomoru/client"
require "docomoru/command_builder"
require "docomoru/version"
require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "socket"

set :bind, '0.0.0.0'

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/' do
	client = Docomoru::Client.new(api_key: "376f5479654d35514574463155363475396c4d6661694f6866576e556c487a5a7669356b394a795068472f")

	ip = Socket.getifaddrs.select{|x|
	  x.name == "eth0" and x.addr.ipv4?
	}.first.addr.ip_address
	
	@ip = ip

	seed1 = '172.17.0.7'
	if seed1.eql?(ip) then
		tnum = 30
	elsif	seed2.eql?(ip) then
		tnum = 20
	else
		tnum = 0
	end

        response = client.create_dialogue("こんにちは", {"age" => "2","t" => tnum})


    @title = container = `hostname` || 'unknown'
	@body = response.body
	erb :index
end


post '/' do
	client = Docomoru::Client.new(api_key: "376f5479654d35514574463155363475396c4d6661694f6866576e556c487a5a7669356b394a795068472f")
	response = client.create_dialogue(params[:text], {"mode" => params[:mode], "context" => params[:context], "t" => "30"})

    @ip=Socket.getifaddrs.select{|x|
      x.name == "eth0" and x.addr.ipv4?
    }.first.addr.ip_address

    @title = container = `hostname` || 'unknown'
    @body = response.body
    erb :index
#  erb %{
#    <p>こんにちは，<%= h params[:name] %>さん！</p>
#    <a href='/'>戻る</a>
#  }
end

