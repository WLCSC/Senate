class AssembliesController < ApplicationController
  # GET /assemblies
  # GET /assemblies.json
  def index
    @assemblies = Assembly.where(:parent_id => nil)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assemblies }
    end
  end

  # GET /assemblies/1
  # GET /assemblies/1.json
  def show
    @assembly = Assembly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assembly }
    end
  end

  # GET /assemblies/new
  # GET /assemblies/new.json
  def new
    @assembly = Assembly.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assembly }
    end
  end

  # GET /assemblies/1/edit
  def edit
    @assembly = Assembly.find(params[:id])
  end

  # POST /assemblies
  # POST /assemblies.json
  def create
    @assembly = Assembly.new(params[:assembly])

    respond_to do |format|
      if @assembly.save
        format.html { redirect_to @assembly, notice: 'Assembly was successfully created.' }
        format.json { render json: @assembly, status: :created, location: @assembly }
      else
        format.html { render action: "new" }
        format.json { render json: @assembly.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assemblies/1
  # PUT /assemblies/1.json
  def update
    @assembly = Assembly.find(params[:id])

    respond_to do |format|
      if @assembly.update_attributes(params[:assembly])
        format.html { redirect_to @assembly, notice: 'Assembly was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assembly.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assemblies/1
  # DELETE /assemblies/1.json
  def destroy
    @assembly = Assembly.find(params[:id])
    @assembly.destroy

    respond_to do |format|
      format.html { redirect_to assemblies_url }
      format.json { head :no_content }
    end
  end
end
