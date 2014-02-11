require 'yaml'

class TwentyQuestions

  attr_accessor :questions_array

  def initialize
    @questions_array = YAML::load(File.read(
      ARGV.empty? ? 'questions_hash.txt' : ARGV[0]))
  end

  def full_session
    final_ans = q_sesh(@questions_array)
    final_ans[2] ? right_answer(final_ans[1]) : wrong_answer(final_ans)
  end

  def right_answer(ans)
    puts "I GOT IT! It was #{find_word(ans)}!"
  end

  def find_word(ans)
    ans.split.last[0..-2]
  end

  def wrong_answer(ans)
    "Dang...can you tell me what the word was?"
    new_ans = gets.chomp
    new_final_q = ["Is it a #{new_ans}?", true, false]
    "Whats a good question to separate #{find_word(ans[1])} from #{new_ans}?"
    new_q = gets.chomp
    "And what is the answer? (#{new_q}) for #{new_ans}?"
    ans[0] = (ans == 1 ? [new_q, new_final_q, ans[0]] : [new_q, ans[0], new_final_q])
  end

  def q_sesh(prev_q, q)
    ask(q)
    q_ans = q[answer]
    q_ans.is_a?(Array) ? q_sesh(q, q_ans) : [prev_q, q, q_ans]
  end
    
  end

  def ask(arr)
    puts arr[0]
  end

  def answer
    ans = gets.chomp
    if ans == "yes" || ans == "y" || ans == "1"
      1
    elsif ans== "no" || ans == "n" || ans = "2"
      2
    else
      puts "not a valid entry"
      get_ans
    end
  end
end

x = TwentyQuestions.new