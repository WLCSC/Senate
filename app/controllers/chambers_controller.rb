class ChambersController < ApplicationController
  # GET /chambers
  # GET /chambers.json
  def index
    @chambers = Chamber.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chambers }
    end
  end

  # GET /chambers/1
  # GET /chambers/1.json
  def show
    @chamber = Chamber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chamber }
    end
  end

  # GET /chambers/new
  # GET /chambers/new.json
  def new
    @chamber = Chamber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chamber }
    end
  end

  # GET /chambers/1/edit
  def edit
    @chamber = Chamber.find(params[:id])
  end

  # POST /chambers
  # POST /chambers.json
  def create
    @chamber = Chamber.new(params[:chamber])

    respond_to do |format|
      if @chamber.save
        format.html { redirect_to @chamber, notice: 'Chamber was successfully created.' }
        format.json { render json: @chamber, status: :created, location: @chamber }
      else
        format.html { render action: "new" }
        format.json { render json: @chamber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chambers/1
  # PUT /chambers/1.json
  def update
    @chamber = Chamber.find(params[:id])

    respond_to do |format|
      if @chamber.update_attributes(params[:chamber])
        format.html { redirect_to @chamber, notice: 'Chamber was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chamber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chambers/1
  # DELETE /chambers/1.json
  def destroy
    @chamber = Chamber.find(params[:id])
    @chamber.destroy

    respond_to do |format|
      format.html { redirect_to chambers_url }
      format.json { head :no_content }
    end
  end

  def announce
	@chamber = Chamber.find(params[:id])
	@announcement = @chamber.announcements.build(:user_id => params[:user_id], :content => params[:content])
	@announcement.save
	redirect_to @chamber
  end
end
