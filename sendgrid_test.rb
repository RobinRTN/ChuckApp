require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: 'no-reply@chuckapp.fr')
to = Email.new(email: 'robinrettien@gmail.com')
subject = 'Sending with SendGrid is Fun'
content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
personalization = Personalization.new
personalization.add_to(to)
mail = SendGrid::Mail.new
mail.from = from
mail.subject = subject
mail.add_content(content)
mail.add_personalization(personalization)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers
