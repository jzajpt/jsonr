# encoding: utf-8

class <%= class_name.pluralize %>Controller < ApplicationController

  # Only JSON responses
  respond_to :json

  before_filter :find_and_assign_<%= var_name %>, :only => [:show, :edit, :update, :destroy]

  def index
    @<%= collection_name %> = <%= class_name %>.paginate(:per_page => 30, :page => params[:page])
  end

  def show
  end

  def new
    @<%= var_name %> = <%= class_name %>.new
  end

  def create
    @<%= var_name %> = <%= class_name %>.new(params[:<%= var_name %>.])

    if @<%= var_name %>.save
      @<%= var_name %>.fire :created, :by => current_user
    else
      render :json => { :errors => @<%= var_name %>.errors }
    end
  end

  def edit
  end

  def update
    if @<%= var_name %>.update_attributes(params[:<%= var_name %>])
      @<%= var_name %>.fire :updated, :by => current_user
    else
      render :json => { :errors => @<%= var_name %>.errors }
    end
  end

  def destroy
    @<%= var_name %>.destroy
    @<%= var_name %>.fire :destroyed, :by => current_user
  end

  protected

  def find_and_assign_<%= var_name %>
    @<%= var_name %> = <%= class_name %>.find(params[:id])
  end

end
