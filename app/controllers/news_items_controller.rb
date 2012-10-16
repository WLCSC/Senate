class NewsItemsController < ApplicationController
  # GET /news_items
  # GET /news_items.json
  def index
    @news_items = NewsItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_items }
    end
  end

  # GET /news_items/1
  # GET /news_items/1.json
  def show
    @news_item = NewsItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_item }
    end
  end

  # GET /news_items/new
  # GET /news_items/new.json
  def new
    @news_item = NewsItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_item }
    end
  end

  # GET /news_items/1/edit
  def edit
    @news_item = NewsItem.find(params[:id])
  end

  # POST /news_items
  # POST /news_items.json
  def create
    @news_item = NewsItem.new(params[:news_item])

    respond_to do |format|
      if @news_item.save
        format.html { redirect_to root_path, notice: 'News item was successfully created.' }
        format.json { render json: @news_item, status: :created, location: @news_item }
      else
        format.html { render action: "new" }
        format.json { render json: @news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news_items/1
  # PUT /news_items/1.json
  def update
    @news_item = NewsItem.find(params[:id])

    respond_to do |format|
      if @news_item.update_attributes(params[:news_item])
        format.html { redirect_to @news_item, notice: 'News item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_items/1
  # DELETE /news_items/1.json
  def destroy
    @news_item = NewsItem.find(params[:id])
    @news_item.destroy

    respond_to do |format|
      format.html { redirect_to news_items_url }
      format.json { head :no_content }
    end
  end
end
