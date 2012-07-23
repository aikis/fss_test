class CampaignsController < ApplicationController
  # GET /campaigns
  # GET /campaigns.xml
  def index
    if params[:view_option]
      case params[:view_option].to_i
        when 2 then @campaigns = Campaign.find(:all, :order => "updated_at ASC")
        when 3 then @campaigns = Campaign.find(:all, :order => "created_at ASC")
        when 4 then @campaigns = Campaign.find(:all, :order => "name ASC")
        when 5 then
          if ids = session[:recent_campaigns]
            @campaigns = Campaign.find(ids)
            @campaigns = ids.map {|id| @campaigns.detect {|x| x.id == id}}
            puts @campaigns
          else
            @campaigns = []
          end
        else @campaigns = Campaign.all
      end
      @selected_option = params["view_option"].to_i
    else
      @selected_option = 1
      @campaigns = Campaign.all
    end
    @options = [['All', 1], ['Updated at', 2], ["Created at", 3], ['Compaign name', 4], ["Recent viewed", 5]]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campaigns }
    end
  end

  # GET /campaigns/1
  # GET /campaigns/1.xml
  def show
    @campaign = Campaign.find(params[:id])
    id = params[:id].to_i
    if session[:recent_campaigns]
      session[:recent_campaigns].delete id
      session[:recent_campaigns].unshift id
    else
      session[:recent_campaigns] = [id]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.xml
  def new
    @campaign = Campaign.new
    @statuses, @types, @owners = prepare_options_for_select(Status.all, Type.all, User.all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = Campaign.find(params[:id])
    @statuses, @types = prepare_options_for_select(Status.all, Type.all)
  end

  # POST /campaigns
  # POST /campaigns.xml
  def create
    options = params[:campaign]
    @campaign = Campaign.new

    respond_to do |format|
      if @campaign.add_attr(options)
        format.html { redirect_to(@campaign, :notice => 'Campaign was successfully created.') }
        format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.xml
  def update
    options = params[:campaign]
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      if @campaign.add_attr(options)
        format.html { redirect_to(@campaign, :notice => 'Campaign was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.xml
  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    session[:recent_campaigns].delete(@campaign.id) if session[:recent_campaigns]

    respond_to do |format|
      format.html { redirect_to(campaigns_url) }
      format.xml  { head :ok }
    end
  end

  def prepare_options_for_select(*items)
    prepared_array = []
    items.each do |item|
      prepared_array << item.map { |option| [option.name, option.id] }
    end
    prepared_array
  end
end
