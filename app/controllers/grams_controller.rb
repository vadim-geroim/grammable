class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @grams = Gram.all
    @comment = Comment.new
  end

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.create(gram_params)

    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity  
    end
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if current_user != @gram.user
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if current_user != @gram.user

    @gram.update_attributes(gram_params)

    if @gram.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end  
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if current_user != @gram.user

    @gram.destroy
    if @gram.errors.empty?
      redirect_to root_path
    end  

  end

  private

  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize}", status: status
  end

  def gram_params
    params.require(:gram).permit(:message, :picture)
  end
end
