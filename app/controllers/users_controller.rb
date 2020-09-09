class UsersController < ApplicationController
  def show
    @user = current_user
    @places = Place.where(owner: nil)
    authorize @user
  end

  def update_position
    @user = current_user
    authorize @user
    @user.latitude = params[:lat].to_f
    @user.longitude = params[:lng].to_f
    @user.save
  end

  def update_messages
    @user = current_user
    authorize @user
    if @user.message_angels.update(message_params)
      redirect_to users_path
    else
      render :show
    end
  end

  # ! DO NOT DELETE
  # def sos_angels
  #   #Precisamos criar uma função que transforme lat e lng em endereço e chamamos na variável abaixo
  #   sos_address = '????'
  #   client = Twilio::REST::Client.new
  #   current_user.angels.each do |a|
  #     client.messages.create({
  #       from: ENV['TWILIO_PHONE'],
  #       to: a.phone_number,
  #       #precisamos inserir em body o endereço que pegamos em sos_address
  #       body: "Oi, aqui é #{current._user.first_name} #{current._user.last_name} "
  #     })
  #   end
  # end

  private

  def message_params
    params.require(:user).permit(:message_angels, :message_near_users, :message_authorities)
  end
end
