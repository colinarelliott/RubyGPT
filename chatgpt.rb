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

    response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [{ role: "user", content: @prompt}],
            temperature: 0.7,
        }
    )
    puts response.dig("choices", 0, "message", "content")
end

puts "Enter your prompt: \n"
prompt = gets.chomp
puts "Your prompt is: " + prompt
puts "Response: \n"
puts gpt(prompt)