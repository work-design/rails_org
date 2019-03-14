//= require rails_taxon/outer
$('#member_parent_id').dropdown({
  apiSettings: {
    url: '/hr/members/leaders?q={query}&department_ids={department_ids}',
    cache: false,
    beforeSend: function(settings) {
      settings.urlData.department_ids = [];
      $('[data-title="department_ancestors"]').each(function(){
        return settings.urlData.department_ids.push(this.value);
      });

      // settings.urlData.department_id = xx;
      return settings;
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
$('#member_job_title_ids').dropdown();
