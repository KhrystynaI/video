class CallsController < ApplicationController

  def create
    head :no_content
    ActionCable.server.broadcast("call_channel", call_params)
  end

  def root
    @current = {id: current_user.id, name: current_user.name, online: current_user.online}
    @users = User.all.reject{|c| c == current_user}.map{|u| [name: u.name, id: u.id, online:u.online]}
    render template: "calls/root", locals: {data: @users, current: @current}
  end

  private

  def call_params
    params.permit(:type, :from, :to, :sdp, call: {})
  end
end
