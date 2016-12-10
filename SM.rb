existorno = File.directory?("SMF")

if existorno == false
  Dir.mkdir("SMF")
  Dir.chdir "SMF"
  File.open("password.txt", 'w')
  File.open("password.txt", 'a+') {|f| f.write("112233")}
  exec('cd ~/Desktop/Memopad
    chflags hidden SMF
    ruby SM.rb')
end

puts "Memopad! Please eneter the password (original password is 112233):"
password = gets.chomp
Dir.chdir "SMF"

if password == File.read("password.txt")
  puts "Would you like to add a line of text, open an existing memo, or create a new memo? (add, open, or create)"
  puts "Type 'changepassword' to change your password"
  addopencreate = gets.chomp
  
  if addopencreate == "add"
  	puts "Which file will you like to add to?"
    puts "Here is a list of existing files:"
    puts Dir.glob("*")
  	filenameadd = gets.chomp

    if filenameadd == "password.txt"
      puts "Access Denied"
    else
      puts "Enter the text you will like to add"
      addtext = gets
      File.open(filenameadd, 'a+') {|f| f.write(addtext)}
    end

  elsif addopencreate == "open"
  	puts "Which file will you like to open?"
    puts "Here is a list of existing files:"
    puts Dir.glob("*")
    filenameopen = gets.chomp

    if filenameopen == "password.txt"
      puts "Access Denied"
    else
      system("open", filenameopen)
    end

  elsif addopencreate == "create"
  	puts "Enter the name of the file you will like to create"
  	filenamecreate = gets.chomp
  	File.open(filenamecreate, 'w')
  	system("open", filenamecreate)

  elsif addopencreate == "changepassword"
  	puts "Enter your old password"
  	oldpassword = gets.chomp
  	if oldpassword == File.read("password.txt")
  		puts "Enter your new password"
  		newpassword = gets.chomp
  		File.open("password.txt", 'w')
  		File.open("password.txt", 'a+') {|f| f.write(newpassword)}
  	else
  		puts "Incorrect password"
  	end
  else 
  	puts "Invalid command"

  end

else
  puts "Incorrect password"
end