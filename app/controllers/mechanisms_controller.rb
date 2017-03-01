class MechanismsController < ApplicationController

  before_action :authenticate_user!

  def index
    @mechanisms = Mechanism.where(user_id: current_user.id).paginate(:page => params[:page])#.includes(:mechanism_subcategory)
  end

  def new
    @mechanism = Mechanism.new
  end

  def create
    mech_params = mechanism_params.merge({
                                           mechanism_category_id: MechanismSubcategory.find(mechanism_params[:mechanism_subcategory_id]).mechanism_category_id,
                                           user_id: current_user.id
                                         })
    @mechanism = Mechanism.new(mech_params)
    if @mechanism.save
      redirect_to mechanisms_path, flash: { notice: 'Изменения сохранены.' }
    else
      render action: 'edit', mechanism: params[:mech_params]
    end
  end

  def edit
    @mechanism = Mechanism.where(id: params[:id], user_id: current_user.id).first
    raise ActionController::RoutingError.new('Страница не найдена') unless @mechanism.present?
  end

  def update
    @mechanism = Mechanism.where(id: params[:id], user_id: current_user.id).first
    raise ActionController::RoutingError.new('Страница не найдена') unless @mechanism.present?

    if @mechanism.update_attributes(mechanism_params)
      redirect_to mechanisms_path, flash: { notice: 'Изменения сохранены.' }
    else
      render action: 'edit', mechanism: params[:mechanism]
    end
  end

  def show
    @mechanism = Mechanism.where(id: params[:id]).includes([:mechanism_subcategory, :mechanism_category]).first
    raise ActionController::RoutingError.new('Страница не найдена') unless @mechanism.present?
  end

  private

  def mechanism_params
    params.require(:mechanism).permit(:description, :long_description, :mechanism_subcategory_id)
  end
end