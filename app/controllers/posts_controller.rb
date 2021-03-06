class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, :except => [:index, :show]  
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10).order("created_at DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.where(post_id: @post).order("created_at DESC") 
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post.user = current_user 
    respond_to do |format|
      if @post.save
      format.html { redirect_to root_path, notice: 'Mejenga fue creada.' }
      format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'La mejenga fue cambiada.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'La mejenga fue borrada.' }
      format.json { head :no_content }
    end
  end
   
  def upvote 
    @post.upvote_by current_user
    @post.user = current_user
    redirect_to :back
  end 

  def downvote
    @post= Post.find(params[:id])
    @post.downvote_by current_user
    redirect_to :back
  end 


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:mejenga, :url,:descripcion, :slug) 
  end

  def require_same_user
    if current_user != @post.user 
      flash[:danger] = "You sneaky bastard, you. Nice try." 
      redirect_to root_path 
    end
  end
end
