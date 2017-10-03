class Api::V1::SeriesController < Api::V1::BaseController
  before_action :authenticate_api_v1_user!

  def index
    series = current_api_v1_user.serie
    render json: series, status: :ok
  end

  def show
    serie = current_api_v1_user.serie.find(params[:id])
    render json: serie, status: :ok
  end

  def create
    serie = current_api_v1_user.serie.build(serie_params)
    if serie.save
      render json: serie, status: :created
    else
      render json: { errors: serie.errors }, status: :unprocessable_entity
    end
  end

  def update
    serie = current_api_v1_user.serie.find_by_imdb(params[:id])
    if serie.update_attributes(serie_params)
      render json: serie, status: :ok
    else
      render json: { errors: serie.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    serie = current_api_v1_user.serie.find_by_imdb(params[:id])
    if serie.destroy
      head :no_content
    else
      head :not_found
    end
  end

  private

  def serie_params
    params.require(:serie).permit(:imdb, :my_rating, :last_episode, :poster_uri, :serie_type)
  end
end
