class PermissionsController < ApplicationController
after_filter :find_chamber
layout "chambers"

def find_chamber
	if params[:chamber_id]
		@chamber = Chamber.find params[:chamber_id]
	end
end	
  def index
    @permissions = Permission.all.sort {|a,b| a.priority <=> b.priority}
	redirect_to chambers_path unless params[:chamber_id]
  end

  def show
    @permission = Permission.find(params[:id])
	@chamber = @permission.chamber unless params[:chamber_id]
  end

  def new
	@chamber = params[:chamber_id] ? Chamber.find(params[:chamber_id]) : nil
	@groups = Group.all
	@principals = @groups[0].all_principals
    @permission = Permission.new
  end

  def create
	#raise "Fail!"
    @permission = Permission.new(params[:permission])
	@permission.chamber_id = params[:permission_chamber_id]
	@permission.principal_id = params[:permission_principal_id]
    if @permission.save
      redirect_to @permission, :notice => "Successfully created permission."
    else
      render :action => 'new'
    end
  end

  def edit
    @permission = Permission.find(params[:id])
	puts @permission.chamber.to_yaml
	@chamber = @permission.chamber 
	#Chamber.find(params[:chamber_id]) if params[:chamber_id]
	@groups = Group.all
	@principals = @groups[0].all_principals
  end

  def update
    @permission = Permission.find(params[:id])
    if @permission.update_attributes(params[:permission])
      redirect_to @permission, :notice  => "Successfully updated permission."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @permission = Permission.find(params[:id])
	@chamber = @permission.chamber
	@principal = @permission.principal
	if @principal.securable.is_a? User
		@chamber.titles_for(@principal.securable).each do |t|
			t.users.delete @principal.securable
			t.save
		end
	else
		@principal.users.each do |u|
			@chamber.titles_for(u).each do |t|
				t.users.delete u unless @chamber.authoritate_without(u,@principal)
				t.save
			end
		end
	end
    @permission.destroy
    redirect_to permissions_url, :notice => "Successfully destroyed permission."
  end
  
  def ajax_update_principals
	@principals = Group.find(params[:principal_group]).all_principals
	render :partial => 'principal_select'
  end
end
