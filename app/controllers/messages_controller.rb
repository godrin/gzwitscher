require 'pp'


class MessagesController < ApplicationController
  before_filter :authenticate_user!

  before_filter :get_user


  READONLY=true

  # GET /messages
  # GET /messages.xml
  def index
    @messages = @user.messages.order("created_at desc").limit(30)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @message.user_id=current_user.id # always save as current_user - never as selected
    respond_to do |format|
      if @message.save
        MessageRelation.create(:user_id=>current_user.id,:message_id=>@message.id)
        format.html { redirect_to([@message.user,@message], :notice => 'Message was successfully created.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  if false

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end




  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
  end


  private
  def get_user
    @user=User.where(:id=>params[:user_id]).first
    @subscribed=Subscription.where(:author_id=>@user.id, :user_id=>current_user.id).first
  end
end
