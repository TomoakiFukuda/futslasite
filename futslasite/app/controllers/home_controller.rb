class HomeController < ApplicationController

PER = 4

def top
    if user_signed_in?
      @note = Note.new
      @notes = Note.all.order(created_at: :desc)
      @event = Event.new
      @user = User.new
      @q = Event.search(params[:q])
      @events = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(PER)
    else
      @message = "ようこそプロトタイプサイトへ！"
    end
  end

def index
@q = Event.search(params[:q])
@events = @q.result(distinct: true)
end

private

def search_params
  params.require(:q).permit!
  resocue
  { start_time_gteq: Time.zone.now }
  end
 
  def about
  end

  include ApplicationHelper
end