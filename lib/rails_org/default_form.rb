require 'default_form'
module RailsOrg::DefaultForm
  
  def collection_members_select(method, value_method, text_method, options = {}, html_options = {})
    organ_handle = OrganHandle.find_by(record_class: object.class.base_class.name, record_column: method)
    if organ_handle
      job_title_ids = organ_handle.department_grants.default_where(organ_id: @template.current_organ&.id).pluck(:job_title_id)
      collection = Member.select(:id, text_method).default_where('member_departments.job_title_id': job_title_ids)
    else
      collection = []
    end
    collection_select(method, collection, value_method, text_method, options, html_options)
  end
  
end

DefaultForm::FormBuilder.include RailsOrg::DefaultForm
