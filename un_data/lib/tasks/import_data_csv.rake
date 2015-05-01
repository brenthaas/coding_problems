require 'csv'

namespace :import_data  do
  task :csv , [:filename] => [:environment] do |t, args|
    if File.exists?(args[:filename])
      CSV.foreach(args[:filename], headers: true) do |row|
        (country, year, count, rate) =
        [row['Country or Area'], row['Year'], row['Count'], row['Rate']]

        if country && year
          puts "Processing stats for #{country} #{row['Year']}..."

          country = Country.find_or_create_by(name: country)
          stat = country.murder_stats.find_or_create_by(year: year)
          stat.update(count: count, rate: rate)
        end
      end
    end
  end
end
