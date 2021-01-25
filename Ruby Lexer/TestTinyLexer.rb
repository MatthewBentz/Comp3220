load "./TinyToken.rb"
load "./TinyScanner.rb"

# Open file and assign first token.
scan = Scanner.new("input.tiny")
tok = scan.nextToken()

# Create "tokens" file.
tokenFile = File.open("tokens", "w")

# Just incase :)
count = 0

while (tok.get_type() != Token::EOF)   

   # Write current token to "tokens" file.
   tokenFile.puts"#{tok}"
   
   # Scan next character and assign next token.
   tok = scan.nextToken()

   count += 1
   if count > 50
   		break
   end

end

# Output EOF
tokenFile.puts"#{tok}"
tokenFile.close