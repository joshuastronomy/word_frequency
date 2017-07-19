require 'pry'

class Wordfreq
  STOP_WORDS = %w[a an and are as at be by for from
                  has he i in is it its of on that the to
                  were will with].freeze

  def initialize(filename)
    @data = File.read(filename).downcase
    @data.gsub!(/[^a-z0-9\s]/i, ' ')
    STOP_WORDS.each do |word|
      @data.gsub!(/\b(?:#{word})\b/, '')
    end
    puts @data
  end

  def frequency(word)
    counter = @data.scan(/\b(?:#{word})\b/).count
    puts counter
  end

  def frequencies
    @f_array = @data.split(' ')

    @counts = Hash.new 0

    @f_array.each do |word|
      @counts[word] += 1
    end
    @counts
    # @counts.sort_by {|word, freq| freq}.reverse!
  end

  def top_words(number)
    sorted_freq = frequencies.sort_by {|word, freq| freq}
  sorted_freq.reverse!
  freq_array = []
  sorted_freq.each do |k, v|
    freq_array << [k, v]
  end
  freq_array.take(number)
  end


  def print_report
  end

end

if $PROGRAM_NAME == __FILE__
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exist?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts 'Please give a filename as an argument.'
  end
end

binding.pry
