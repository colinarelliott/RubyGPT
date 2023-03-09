# Description: GPT-3 chatbot

require "openai"
require "dotenv"

# Load the .env file
Dotenv.load(".env")

# Copy the .env.dist file to .env and add your API key
OpenAI.configure do |config|
    config.access_token = ENV.fetch('API_KEY')
end

def gpt(prompt)
    # Create an API client
    client = OpenAI::Client.new

    response = client.create_completions( # wrong method name, needs fixing
    engine: model,
    prompt: prompt,
    max_tokens: 50,
    temperature: 0.5,
    stop: ['\n', 'User:']
    )

    # Return the first response
    response.choices[0].text.strip
end

puts "Enter your prompt: \n"
prompt = gets.chomp
puts "cgpt: "
puts gpt(prompt)

# make a loop to keep asking for input
while true do
    puts "you: "
    prompt = gets.chomp
    puts "cgpt: "
    puts gpt(prompt)
end