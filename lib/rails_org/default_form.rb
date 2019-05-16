require 'default_form'
module RailsOrg::DefaultForm
  
  def collection_members_select(method, value_method, text_method, options = {}, html_options = {})
    org_config = OrgConfig.default_where(@template.default_params).find_by(record_class: object.class.base_class.name, record_column: method)
    if org_config
      collection = Member.select(:id, text_method).default_where('member_departments.job_title_id': org_config.job_title_ids)
    else
      collection = []
    end
    collection_select(method, collection, value_method, text_method, options, html_options)
  end
  
end

DefaultForm::DefaultBuilder.include RailsOrg::DefaultForm
