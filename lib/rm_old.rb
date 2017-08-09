require 'trollop'
require "rm_old/version"

module RmOld
	class App
		def main
			opts = Trollop::options do
				version "rm_old --age=n [--test] <files> (c) 2016 @reednj"
				opt :age, "delete any files older than this (ex. 1d, 36h)", :type => :string
				opt :test, "print the list of matched files, but don't delete"
			end

			if opts[:age].nil?
				# the only thing we really need specified is the age. We can use
				# defaults for everything else
				Trollop::educate
			end

			max_age = opts[:age].to_duration
			matched = ARGV.select {|f| File.file?(f) && File.mtime(f).age > max_age }

			puts 'Listing files only, will not delete' if opts[:test]
			matched.each do |f|
				if !opts[:test]
					File.delete(f)
				else
					puts f
				end
			end
		end
	end
end

class String
	def to_duration
		s = self.gsub(' ', '').strip
		unit = s.last
		ord = s.chomp(unit).to_f
		
		second = 1.0
		minute = second * 60
		hour = minute * 60
		day = hour * 24
		week = day * 7

		return ord * week if unit == 'w'
		return ord * day if unit == 'd'
		return ord * hour if unit == 'h'
		return ord * minute if unit == 'm'
		return ord * second if unit == 's'
		raise "could not parse duration #{self}"
	end

	def last
		self[-1, 1]
	end
end

class Time
	def age
		Time.now - self
	end
end

