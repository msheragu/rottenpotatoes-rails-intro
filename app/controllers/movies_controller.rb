class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  # def index
  #   @movies = Movie.all.order(:title)
  #   if params[:title_sort] == "on"
  #     @movies = Movie.all.order(:title)
  #     @movie_hilite = "hilite"
  #   elsif params[:date_sort] == "on"
  #     @movies = Movie.all.order(:release_date)
  #     @date_hilite = "hilite"
  #   else
  #     @movies = Movie.all
  #   end
  # end
  def index
    # @movies = Movie.all.order(:title)
    
    # session[:filtered_ratings] = nil
    # if params[:ratings] != nil
    #   @filtered_ratings = params[:ratings].keys
    #   session[:filtered_ratings] = @filtered_ratings
    #   @movies = Movie.all.where({rating: @filtered_ratings})
    # end
    # @all_ratings = Movie.all_ratings
    
    # if session[:filtered_ratings] = nil
    #   session[:filtered_ratings] = Movie.all_ratings
    # end
    # if !params[:ratings].nil?
    #   session[:filtered_ratings] = params[:ratings].keys
    # end
    # if !params[:sort_by].nil?
    #   session[:sort_by] = params[:sort_by]
    #   # @movies = Movie.order(params[:sort_by])
    # end
    @movies=Movie.all
    @all_ratings = Movie.all_ratings
    session[:sort_by] = params[:sort_by] unless params[:sort_by].nil?
    @sort_column=session[:sort_by]
    # if !session[:filtered_ratings]
    #   session[:filtered_ratings]=Movie.all_ratings
    # end
    if params[:ratings]
      @filtered_ratings = params[:ratings].keys
      session[:filtered_ratings] = @filtered_ratings
      @movies=Movie.where(rating: @filtered_ratings).order(@sort_column)
    elsif session[:filtered_ratings] !=nil
      @movies=Movie.where(rating: session[:filtered_ratings]).order(@sort_column)
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
