require "docomoru/client"
require "docomoru/command_builder"
require "docomoru/version"
require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "socket"
require "json"

set :bind, '0.0.0.0'

## Configuration ######################
d_api = "376f5479654d35514574463155363475396c4d6661694f6866576e556c487a5a7669356b394a795068472f"
nic_name = "en0"
seed_ip1 = '172.17.0.7'
seed_ip2 = '172.17.0.8'
init_talk = "こんにちは"
#######################################

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/' do
	client = Docomoru::Client.new(api_key: d_api)

	ip = Socket.getifaddrs.select{|x|
	  x.name == nic_name and x.addr.ipv4?
	}.first.addr.ip_address

	if seed_ip1.eql?(ip) then
		tnum = 30
		@color = 'pink'
	elsif	seed_ip2.eql?(ip) then
		tnum = 20
		@color = 'white'
	else
		tnum = 0
		@color = 'white'
	end

    response = client.create_dialogue(init_talk, {"age" => "30","t" => tnum})

   	@title = container = `hostname` || 'unknown'
	@body = response.body

    @comment = JSON.generate({"body" => response.body})

	erb :index
end


post '/comment' do
	client = Docomoru::Client.new(api_key: d_api)

        ip = Socket.getifaddrs.select{|x|
          x.name == nic_name and x.addr.ipv4?
        }.first.addr.ip_address


        if seed_ip1.eql?(ip) then
                tnum = 30
                @color = 'pink'
        elsif   seed_ip2.eql?(ip) then
                tnum = 20
                @color = 'white'
        else
                tnum = 0
                @color = 'white'
        end

	response = client.create_dialogue(params[:body], {"mode" => params[:mode], "context" => params[:context], "t" => tnum})

    @title = container = `hostname` || 'unknown'
    @body = response.body

    @res = JSON.pretty_generate({:body => response.body["utt"],
                          :mode => response.body["mode"],
                          :context => response.body["context"]
                          })
end

