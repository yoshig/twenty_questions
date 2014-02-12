require 'yaml'
require 'debugger'

class TwentyQuestions

  attr_accessor :questions_array

  def initialize
    @questions_array = YAML::load(File.read(
      ARGV.empty? ? 'questions_hash.txt' : ARGV[0]))
  end

  def full_session
    final_ans = q_sesh(@questions_array, @questions_array[1])
    final_ans[2] ? right_answer(final_ans[1][0]) : wrong_answer(final_ans[0])
  end

  def q_sesh(prev_q, q)
    ask(q)
    debugger
    p "QUESTOIN"
    p q
    q_ans = q[answer]
    p q_ans
    q_ans.is_a?(Array) ? q_sesh(q, q_ans) : [prev_q, q, q_ans]
  end

  def wrong_answer(ans)
    #To preserve the array rather than rewrite it, I just popped out the ans
    p ans
    prev_q, old_final_q, q_ans = ans.shift, ans.shift, ans.shift
    puts "Dang...what was the word?"
    new_ans = gets.chomp
    new_final_q = ["Is it a #{new_ans}?", true, false]
    puts "What's a good question to separate " +
      "#{find_word(old_final_q[0])} from #{new_ans}?"
    new_q = gets.chomp
    ans << prev_q << [new_q, new_final_q, old_final_q]
    debugger
    puts "And what is the answer (#{new_q}) for #{new_ans}?"
    ans[1][1], ans[1][2] = [ans[1][2], ans[1][1]] if answer == 2
    save_answer
  end

  def right_answer(ans)
    puts "I GOT IT! It was #{find_word(ans)}!"
  end

  def find_word(ans)
    ans.split.last[0..-2]
  end

  def save_answer
    File.open("questions_hash.txt", "w") do |f|
      f.puts @questions_array.to_yaml
    end
  end

  def ask(arr)
    puts arr[0]
  end

  def answer
    ans = gets.chomp
    if ans == "yes" || ans == "y" || ans == "1"
      1
    elsif ans == "no" || ans == "n" || ans == "2"
      2
    else
      puts "not a valid entry"
      answer
    end
  end
end

x = TwentyQuestions.new
x.full_session