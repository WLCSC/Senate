class PermissionsController < ApplicationController
	before_filter :check_for_user
	before_filter :find_chamber
  # GET /permissions
  # GET /permissions.json
  def index
    
    if params[:board_id]
		@board = Board.find(params[:board_id])
		@permissions = @board.permissions.all
		@securable = @board
	elsif params[:proposal_id]
		@proposal = Proposal.find(params[:proposal_id])
		@permissions = @proposal.permissions.all
		@securable = @proposal
    else
	@permissions = @chamber.permissions.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @permissions }
    end
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
    @permission = Permission.find(params[:id])

    case @permission.securable_type
    when 'Chamber'
	    redirect_to chamber_permissions_path(@permission.securable)
    when 'Board'
	    redirect_to chamber_board_permissions_path(@permission.securable.chamber, @permission.securable)
    when 'Proposal'
	    redirect_to chamber_proposal_permissions_path(@permission.securable.chamber, @permission.securable)
    end
    
  end

  # GET /permissions/new
  # GET /permissions/new.json
  def new
    @permission = Permission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])
  end

  # POST /permissions
  # POST /permissions.json
  def create
    @permission = Permission.new(params[:permission])

    respond_to do |format|
      if @permission.save
        format.html { redirect_to (@permission.securable.is_a?(Chamber) ? [@permission.securable, @permission] : [@permission.securable.chamber, @permission.securable, @permission]), notice: 'Permission was successfully created.' }
        format.json { render json: @permission, status: :created, location: @permission }
      else
        format.html { render action: "new" }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /permissions/1
  # PUT /permissions/1.json
  def update
    @permission = Permission.find(params[:id])

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.html { redirect_to @permission, notice: 'Permission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.json
  def destroy
    @permission = Permission.find(params[:id])
    case @permission.securable_type
    when 'Chamber'
	    redirect_to chamber_permissions_path(@permission.securable)
    when 'Board'
	    redirect_to chamber_board_permissions_path(@permission.securable.chamber, @permission.securable)
    when 'Proposal'
	    redirect_to chamber_proposal_permissions_path(@permission.securable.chamber, @permission.securable)
    end
    @permission.destroy
  end
end
