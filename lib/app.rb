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
    # if there is a tag thing
    #   ideas = tag selection, etc.(tag)
    # else
    ideas = IdeaStore.all.sort
    erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new(params)}
  end

  def clean_tags(idea_tags)
    idea_tags['tags'] =
    (idea_tags['tags']||"").split(", ")
  end

  post '/' do
    uploader = ImageUploader.new
      uploader.store!(params['idea']['image'])
      params['idea']['images'] = params['idea']['image'][:filename]
      params[:idea]['images'] = params['idea']['image'][:filename]
      params_without_image = params['idea'].delete('image')
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
    # if the params for image 'value' == idea.images
    #  then don't bother trying to upload an image because there isn't one
    #  you might need to clean up the params by running: params_without_image = params['idea'].delete('image')
    # else do the stuff below
    uploader = ImageUploader.new
      uploader.store!(params['idea']['image'])
      params['idea']['images'] = params['idea']['image'][:filename]
      params[:idea]['images'] = params['idea']['image'][:filename]
      params_without_image = params['idea'].delete('image')
    clean_tags params[:idea]
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

end
