namespace :import do
  desc "Import exercises from CSV file"
  task exercises: :environment do
    CSV.foreach('./lib/output.csv', headers: true) do |row|
      Exercise.create(row.to_h)
    end
    puts "Exercises imported!"
  end
end
