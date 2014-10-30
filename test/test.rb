gem 'minitest'                           # => true
require 'minitest/autorun'               # => true
require 'minitest/pride'                 # => true
require_relative '../lib/idea_box/idea'  # => true

class IdeaTest < Minitest::Test
  def test_idea_exists
    idea = Idea.new("attributes")                 # => #<Idea:0x007feabd07afa8 @title=nil, @description=nil, @rank=0, @id=nil, @tags=nil, @category=nil>
    assert_equal "title", idea.title
    assert_equal "description", idea.description
  end

  def test_ideas_can_be_liked
    skip
    idea = Idea.new("title", "description")
    assert_equal 0, idea.rank
    idea.like!
    assert_equal 1, idea.rank
    idea.like!
    assert_equal 2, idea.rank
  end

  def test_ideas_can_be_sorted_by_rank
    skip
    diet = Idea.new("diet", "cabbage soup")
    exercise = Idea.new("exercise", "long distance running")
    drink = Idea.new("drink", "carrot smoothie")
    exercise.like!
    exercise.like!
    drink.like!
    ideas = [drink, exercise, diet]
    assert_equal [diet, drink, exercise], ideas.sort
  end

  def test_ideas_have_an_id
    skip
    idea = Idea.new("dinner", "beef stew")
    idea.id = 1
    assert_equal 1, idea.id
  end

  def test_update_values
    skip
    idea = Idea.new("hello", "describing!")
    idea.title = "happy hour"
    idea.description = "mojitos"
    assert_equal "happy hour", idea.title
    assert_equal "mojitos", idea.description
  end

  def test_idea_can_be_updated
    skip
    idea = Idea.new("teach", "some ruby")
    id = IdeaStore.save(idea)
    idea = IdeaStore.find(id)
    idea.title = "cocktails"
    idea.description = "spicy tomato juice with vodka"
    IdeaStore.save(idea)
    assert_equal 1, IdeaStore.count
    idea = IdeaStore.find(id)
    assert_equal "cocktails", idea.title
    assert_equal "spicy tomato juice with vodka", idea.description
  end

end

# >> Run options: --seed 29189
# >>
# >> # Running:
# >>
# >> [31mS[0m[32mS[0m[33mS[0m[34mS[0m[41m[37mF[0m[35mS[0m
# >>
# >> [31mF[0m[32ma[0m[33mb[0m[34mu[0m[35ml[0m[36mo[0m[31mu[0m[32ms[0m[33m [0m[34mr[0m[35mu[0m[36mn[0m in 0.001266s, 4739.3365 runs/s, 789.8894 assertions/s.
# >>
# >>   1) Failure:
# >> IdeaTest#test_idea_exists [/Users/kungfu2/turing/module2/week1/ideabox/test/test.rb:9]:
# >> Expected: "title"
# >>   Actual: nil
# >>
# >> 6 runs, 1 assertions, 1 failures, 0 errors, 5 skips
# >>
# >> You have skipped tests. Run with --verbose for details.
