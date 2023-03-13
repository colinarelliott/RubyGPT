# Description: GPT-3 chatbot

# my precious gems
require "openai"
require "dotenv"
require "json"

# Load the .env file
Dotenv.load(".env")

# Copy the .env.dist file to .env and add your API key
OpenAI.configure do |config|
    config.access_token = ENV.fetch('API_KEY')
end

# Create an API client
client = OpenAI::Client.new

#gpt response function
def gpt(prompt, client)
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt}],
        temperature: 0.7,
    })
    return response
end
# get user input
puts "Enter your prompt: \n"
prompt = gets.chomp
# get gpt response
puts "cgpt: "
response = gpt(prompt, client)
# parse the response
parsedResponse = JSON.parse(response.body)
# print the response
puts parsedResponse["choices"][0]["message"]["content"].tr("\n", " ")

# make a loop to keep asking for input & repeatedly follow these steps
while true do
    puts "you: "
    prompt = gets.chomp
    puts "cgpt: "
    response = gpt(prompt, client)
    parsedResponse = JSON.parse(response.body)
    puts parsedResponse["choices"][0]["message"]["content"].tr("\n", " ")
end