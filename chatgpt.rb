# Description: GPT-3 chatbot in Ruby
# Written by @colinarelliott on GitHub
# Version: 1.0
# Last updated: 2023-03-13

# my precious gems
require "openai"
require "dotenv"
require "json"
require "colorize"

# Load the .env file
Dotenv.load(".env")

# Copy the .env.dist file to .env and add your API key
OpenAI.configure do |config|
    begin
    config.access_token = ENV.fetch('API_KEY')
    rescue KeyError
        puts "NO API KEY DETECTED! Please add your API key to the .env file.".red
        exit
    end
end

# Create an API client
client = OpenAI::Client.new

# Create a variable to hold all responses for 'memory'
$responses = []

#gpt response function
def gpt(prompt, client)
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt}],
        temperature: 0.9,
    })
    $responses.push(response)
    return $responses.last
end

# Introductions are in order
puts "\n\n\n\n\n\n"
puts "------------------------------------------".green
puts "-- Welcome to the ChatGPT Ruby Chat Bot! -".green
puts "------------------------------------------".green
puts "------------------ v1.0 ------------------".green
puts "------------------------------------------".green
puts "--- Type 'help' for a list of commands.---".green
puts "------------------------------------------".green

puts "\nChatGPT: ".red
puts "Hello! I am RubyGPT, a Ruby chatbot powered by GPT-3.5 Turbo. I can talk about anything you want. Type 'help' for a list of commands.\n"

# make a loop to keep asking for input & repeatedly follow these steps
while true do
    puts "\nYou: ".cyan
    prompt = gets.chomp
    # if the prompt is an exit command, exit the program
    if (prompt == "exit" || prompt == "quit" || prompt == "bye" || prompt == "goodbye")
        puts "\nChatGPT: ".red
        puts "Goodbye!"
        break
    end
    # if the prompt is a help, show the help message
    if (prompt == "help" || prompt == "commands" || prompt == "command" || prompt == "howto")
        puts "\n------------------------------------------".green
        puts "Here are the possible commands:".green
        puts "exit, quit, goodbye: " +  " EXIT THE PROGRAM".yellow
        puts "help, commands, command, howto: " + " SHOW THIS MESSAGE".yellow
        puts "------------------------------------------".green
    end
    puts "\nChatGPT: ".red
    response = gpt(prompt, client)
    parsedResponse = JSON.parse(response.body)
    puts parsedResponse["choices"][0]["message"]["content"].tr("\n", " ").sub!(/\A.{2}/m, '') + "\n"
end