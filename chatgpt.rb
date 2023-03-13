# Description: GPT-3 chatbot

# my precious gems
require "openai"
require "dotenv"
require "json"
require "colorize"

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

#intro
puts "------------------------------------------".green
puts "Welcome to the ChatGPT Ruby Chat Bot!".green
puts "------------------------------------------".green

# get user input
puts "Enter your prompt: ".cyan
prompt = gets.chomp
# get gpt response
puts "cgpt: ".red
response = gpt(prompt, client) #calls gpt function
# parse the response
parsedResponse = JSON.parse(response.body)
# grab the actual content of the response
stringResponse = parsedResponse["choices"][0]["message"]["content"].tr("\n", " ").sub!(/\A.{2}/m, '')
# print the response
puts stringResponse


# make a loop to keep asking for input & repeatedly follow these steps
while true do
    puts "you: ".cyan
    prompt = gets.chomp
    if (prompt == "exit" || prompt == "quit" || prompt == "bye" || prompt == "goodbye")
        puts "cgpt: "
        puts "Goodbye!"
        break
    end
    if (prompt == "help" || prompt == "commands" || prompt == "command" || prompt == "howto")
        puts "Here are the possible commands:\n"
        puts "exit, quit, goodbye: EXIT THE PROGRAM\n"
        puts "help, commands, command, howto: SHOW THIS MESSAGE\n"
    end
    puts "cgpt: ".red
    response = gpt(prompt, client)
    parsedResponse = JSON.parse(response.body)
    puts parsedResponse["choices"][0]["message"]["content"].tr("\n", " ").sub!(/\A.{2}/m, '')
end