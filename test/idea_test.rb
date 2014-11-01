gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/idea_box/idea'

class IdeaTest < Minitest::Test
  def test_idea_exists
    skip
    idea = Idea.new("attributes")
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

  def test_liked_ideas_can_be_sorted
    animal = Idea.new("animal", "panda")
    vegetable = Idea.new("vegetable", "beet")
    mineral = Idea.new("mineral", "limonite")
    animal.like!
    vegetable.like!
    mineral.like!
    ideas = [animal, vegetable, mineral]
    assert_equal [animal, vegetable, mineral], ideas.sort
  end

  def test_ideas_have_an_id
    skip
    idea = Idea.new("animal", "cobra")
    idea.id = 1
    assert_equal 1, idea.id
  end

  def test_update_values
    skip
    idea = Idea.new("oh hello", "description")
    idea.title = "tacos of terror"
    idea.description = "delicious"
    assert_equal "boneyard burritos", idea.title
    assert_equal "delicious", idea.description
  end

end
