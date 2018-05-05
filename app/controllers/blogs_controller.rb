class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end
  def new
    if params[:back]
      @blog = Blog.new(blog_param)
    else
      @blog = Blog.new
    end
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end
  
  def create
    @blog = Blog.new(blog_param)
    
    if @blog.save
      redirect_to blogs_path
    else
      render "new"
    end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_param)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
  private
  def blog_param
     params.require(:blog).permit(:title, :content) 
  end
end
