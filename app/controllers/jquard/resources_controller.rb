module Jquard
  class ResourcesController < ApplicationController
    before_action :set_resource, except: :root
    before_action :set_record, only: [ :edit, :update, :destroy ]

    def root
      first = Jquard.registry.resources.min_by { |resource| [ resource.navigation_sort, resource.navigation_label ] }

      if first
        redirect_to resource_path(first.slug)
      else
        render plain: "No Jquard resources registered. Run `bin/rails generate jquard:resource YourModel`."
      end
    end

    def index
      @page = @resource.page_for(:index)
      @table = @resource.build_table
      @query_params = params.permit(:q, :sort, :direction, :page, :per_page)
      @result = Jquard::Tables::Query.new(
        table: @table,
        scope: @resource.model.all,
        params: @query_params
      ).result
    end

    def new
      @page = @resource.page_for(:create)
      @form_schema = @resource.build_form
      @record = @resource.model.new
      @form_schema.apply_defaults(@record)
    end

    def create
      @page = @resource.page_for(:create)
      @form_schema = @resource.build_form

      data = @page.mutate_form_data_before_create(record_params.to_h)
      @record = @page.handle_record_creation(@resource.model, data)

      if @record.persisted?
        @page.after_create(@record)
        redirect_to @page.redirect_url_after_create(@record) || edit_resource_path(@resource.slug, @record.id),
          notice: @page.created_notification_message
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @page = @resource.page_for(:edit)
      @form_schema = @resource.build_form
    end

    def update
      @page = @resource.page_for(:edit)
      @form_schema = @resource.build_form

      data = @page.mutate_form_data_before_save(record_params.to_h)

      if @page.handle_record_update(@record, data)
        @page.after_save(@record)
        redirect_to @page.redirect_url_after_save(@record) || edit_resource_path(@resource.slug, @record.id),
          notice: @page.saved_notification_message
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @record.destroy
      redirect_to resource_path(@resource.slug), notice: "#{@resource.singular_label} deleted"
    end

    private

    def set_resource
      @resource = Jquard.registry.fetch(params[:resource_slug]) do
        raise ActionController::RoutingError,
          "No Jquard resource registered for #{params[:resource_slug].inspect}"
      end
    end

    def set_record
      @record = @resource.model.find(params[:record_id])
    end

    def record_params
      params.require(@resource.model.model_name.param_key)
            .permit(*@resource.build_form.field_names)
    end
  end
end
