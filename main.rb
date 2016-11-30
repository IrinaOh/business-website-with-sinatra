require 'sinatra'
require 'sendgrid-ruby'
include SendGrid
#################################
get '/home' do
	erb :home
end
get '/about' do
	erb :about
end
get '/shop' do
	erb :shop
end
get '/contactus' do 
	puts params.inspect
	erb :contactus
end
###################################
post '/contact' do
	puts params.inspect
	@username = params[:username]
	@email = params[:email]
	@phone = params[:phone]
	@message = params[:message]

	data = JSON.parse('{
	  "personalizations": [
	    {
	      "to": [
	        {
	          "email": "irina.v.ohara@gmail.com"
	        }
	      ],
	      "subject": "' + params[:username] + '" 
	    }
	  ],
	  "from": {
	    "email": "' + params[:email] + '"
	  },
	  "content": [
	    {
	      "type": "text/plain",
	      "value": "' + params[:phone] + ' ' + params[:message] + '" 
	    }
	  ]
	}')
	sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
	response = sg.client.mail._("send").post(request_body: data)
	puts response.status_code
	puts response.body
	puts response.headers
	erb :contactus
end