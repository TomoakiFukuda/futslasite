class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  include ApplicationHelper

  def show
  end

  def index
  @q = Event.search(params[:q])
  @events = @q.result(distinct: true)
  end

  def new
   event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: "投稿が保存されました"
    else
      # @notesを定義してください
      @events = Event.all.order(created_at: :desc)
      # renderメソッドで表示するビューが、views/home/top.html.erbになるように変更してください
      render 'home/top'
      
    end
  end

  def edit
  end

 def update
    file = params[:event][:image]
    @event.set_eventimage(file)

    if @event.update(event_params)
      redirect_to @event, notice: 'ユーザー情報が更新されました'
    else
      render :edit
    end
 end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :place, :start_time, :end_time, :content, :image)
    end

    def correct_user
      event = Event.find(params[:id])
      if !current_user?(event.user)
        redirect_to root_path, alert: '許可されていないページです'
      end
    end

end
