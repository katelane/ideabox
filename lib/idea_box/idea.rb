require 'yaml/store'

class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id, :tags, :category, :image

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
    @rank = attributes["rank"] || 0
    @id = attributes["id"]
    @tags = attributes["tags"]
    @category = attributes["category"]
    @image = attributes["image"]
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank,
      "tags" => tags,
      "category" => category,
      "image" => image
    }
  end

  def database
    Idea.database
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    other.rank <=> rank
  end

end
