require 'bundler'
Bundler.require
require 'idea_box'
require './lib/idea_box/image_uploader'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    erb :error
  end

  get '/' do
    if params["tag"]
      tag = params["tag"]
      ideas = IdeaStore.filter_by(tag)
    else
      ideas = IdeaStore.all.sort
    end
    erb :index, locals: {ideas: ideas}
  end

  def clean_tags(idea_tags)
    idea_tags['tags'] =
    (idea_tags['tags']||"").split(", ")
  end

  post '/' do
    image_handler
    clean_tags params[:idea]
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/:id' do |id|
    image_handler
    clean_tags params[:idea]
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  #Horace's magic
    # idea_params = params["idea"]
    #  if params["idea"]["image"]
    #    ImageUploader.new.store!(params['idea']['image'])
    #    filename = params['idea']['image'][:filename]
    #    idea_params.merge!({"image" => filename})
    #  end
    #  IdeaStore.update(id.to_i, idea_params)

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  def image_handler
    idea_params = params["idea"]
      if params["idea"]["image"]
        ImageUploader.new.store!(params['idea']['image'])
        filename = params['idea']['image'][:filename]
        idea_params.merge!({"image" => filename})
      end
  end

end
