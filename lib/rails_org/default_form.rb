require 'default_form'
module RailsOrg::DefaultForm
  
  def collection_members_select(method, value_method, text_method, options = {}, html_options = {})
    jt_ids = OrgConfig.where(record_class: object.class.base_class.name, record_column: method).pluck(:job_title_id)
    collection = Member.select(:id, text_method).default_where('member_departments.job_title_id': jt_ids)
    collection_select(method, collection, value_method, text_method, options, html_options)
  end
  
end

DefaultForm::DefaultBuilder.include RailsOrg::DefaultForm
