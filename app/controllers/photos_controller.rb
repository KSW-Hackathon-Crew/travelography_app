class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    Photo.create({photo_url: params[:photo_url], user_id: session[:user_id]})
    respond_to do |format|
      format.json { render :json => 'Photo Saved!'}
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    # photo = @photo.photo_url = params[:photo_url]
    @photo.update({photo_url: params[:photo_url]})
    image_from_web  = open(params[:photo_url]) {|f| f.read }
    file_name = params[:photo_url].split("/").pop()
    File.open(file_name, 'wb') {|f| f.write(image_from_web) }


     respond_to do |format|
      format.json { render :json => 'Photo Updated!'}
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:activity_id, :photo_url)
    end
end
