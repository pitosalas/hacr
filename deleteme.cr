puts Time.parse("2015-10-12 10:30:00 +00:00", "%Y-%m-%d %H:%M:%S %z", Time::Location.local)

puts Time.parse!("2015-10-12 10:30:00 +00:00", "%F %T %:z")
