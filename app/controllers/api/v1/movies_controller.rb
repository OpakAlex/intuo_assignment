class Api::V1::MoviesController < ApplicationController
  MOVIES_PER_PAGE = 25

  def index
    render json: search, each_serilizer: Api::V1::MovieSerializer
  end

  def show
    item = Movie.find_by_id(params[:id])
    render json: item, serializer: Api::V1::MovieSerializer
  end

  def create
    movie = Movie.create(permit_params)
    if movie.save
      movie.create_members(params[:movie][:members])
      return render json: movie, serializer: Api::V1::MovieSerializer, status: 201
    end
    render json: movie.errors.full_messages, status: 422
  end

  private

  def search
    collection = Movie.includes(:members, :directors).order(params[:sort] || 'rating asc').paginate(paginate_params)
    collection = collection.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    if params[:member].present?
      movie_ids = Member.joins(:movie_members).where("name LIKE ?", "%#{params[:member]}%").pluck("movie_id")
      collection = collection.where("id in (?)", movie_ids)
    end
    collection
  end

  def permit_params
    params.require(:movie).permit(:title, :rating, :url)
  end

  def paginate_params
    {page: params[:page] || 1, per_page: MOVIES_PER_PAGE}
  end
end
