class EventsController < ApplicationController
	before_filter :find_chamber
  # GET /events
  # GET /events.json
  def index
    @events = @chamber.events.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to [@chamber, @event], notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to [@chamber,@event], notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to chamber_events_url(@chamber) }
      format.json { head :no_content }
    end
  end

  def attend
	@event = Event.find(params[:id])
	Attendee.create!(:event_id => @event.id, :user_id => current_user.id)
	redirect_to [@chamber, @event], :info => 'You are now attending this event.'
  end

  def unattend
	@event = Event.find(params[:id])
	Attendee.where(:event_id => @event.id, :user_id => current_user.id).first.delete
	redirect_to [@chamber, @event], :info => 'You are no longer attending this event.'
  end
end
