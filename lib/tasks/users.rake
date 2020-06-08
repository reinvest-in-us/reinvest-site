namespace :users do
  desc "Creates a user with editing privileges"
  task :create, [:email] => :environment do |t, args|
    user = if args[:email]
      User.new(email: args[:email])
    else
      puts "Enter the user's email\n "
      email = STDIN.gets.chomp
      User.new(email: email)
    end

    puts "Enter the desired password (20+ characters)\n"
    password = STDIN.gets.chomp
    user.password = password

    if user.valid?
      user.save
      puts "User created with email: #{user.email}"
    else
      puts user.errors.full_messages
    end
  end
end
