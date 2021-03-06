class PhotosController < ApplicationController

  before_filter :load_album, :except => [:new, :create,:index]

  layout "admin"

  def index
    @album = Album.find(params[:album_id])
    @photos = @album.photos
    if !@photos.blank?
      render :json => { :thumbnail=> @photos.first.image.url(:thumbnail).to_s, :url => @photos.first.image.url, :id => @photos.first.id , :name => @photos.first.image.instance.attributes["image_file_name"] }, :content_type => 'text/html'
    else
      render :json => { :pic_path => params[:file] }
    end
  end

  def new
    @album = Album.find(params[:album_id])
    @photo = @album.photos.build
  end

  def create
    @album = Album.find(params[:album_id])
    @photo = @album.photos.new(params[:photo])
    if @photo.save
        render :json => { :thumbnail=> @photo.image.url(:thumbnail).to_s, :url => @photo.image.url, :id => @photo.id , :name => @photo.image.instance.attributes["image_file_name"] }, :content_type => 'text/html'
      else
        render :json => { :url => "/images/image_missing.png" , :name => "Undefine Format Of Photo" }, :content_type => 'text/html'
      end
  end

  def edit
  end

  def update
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated image."
      redirect_to album_path(@album)
    else
      flash[:error] = "Image was not succesfully updated"
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo.destroy
    redirect_to album_path(@album)
  end

  private

  def allow_to
    super :admin, :all => true
  end

  def load_album
     @album = Album.find(params[:album_id])
     @photo = @album.photos.find(params[:id])
  end
end