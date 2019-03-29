//= require rails_taxon/outer
$('#member_job_title_ids').dropdown({
  apiSettings: {
    url: '/panel/job_titles/search?department_id={department_id}',
    cache: false,
    beforeSend: function(settings) {
      var department_id = $('[data-title="node_ancestors"]').first();
      if (department_id.length > 0) {
        return settings.urlData.department_id = department_id[0].value;
      } else {
        return settings.urlData.department_id = 0;
      }
    }
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
$('#member_type').dropdown();
$('#member_office_id').dropdown();
$('#member_band_id').dropdown();
