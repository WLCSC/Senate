class BoardsController < ApplicationController
	before_filter :find_chamber
	before_filter :check_for_user
  # GET /boards
  # GET /boards.json
  def index
    @boards = @chamber.boards.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @board }
    end
  end

  # GET /boards/new
  # GET /boards/new.json
  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(params[:board])

    respond_to do |format|
      if @board.save
				Log.create(:user => current_user, :chamber => @chamber, :action_type => "Board", :action_id => @board.id, :comment => "created a new discussion board")
        format.html { redirect_to [@chamber,@board], notice: 'Board was successfully created.' }
        format.json { render json: @board, status: :created, location: @board }
      else
        format.html { render action: "new" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.json
  def update
    @board = Board.find(params[:id])

    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.html { redirect_to [@chamber,@board], notice: 'Board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board = Board.find(params[:id])
		name = @board.display
		if @board
    @board.destroy

    respond_to do |format|
			Log.create(:user => current_user, :chamber => @chamber, :action_type => nil, :action_id => nil, :comment => "removed the #{name} discussion board")
      format.html { redirect_to chamber_boards_url(@chamber) }
      format.json { head :no_content }
    end
		else
			redirect_to session[:return_to], :notice => "Discussion Board was already deleted."
		end
  end
end
