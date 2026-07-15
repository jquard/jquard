module FormBuilderHelper
  def builder_for(record)
    ActionView::Helpers::FormBuilder.new(
      record.model_name.param_key, record, vc_test_controller.view_context, {}
    )
  end
end
