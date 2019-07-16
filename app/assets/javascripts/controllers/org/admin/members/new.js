//= require rails_taxon/outer
$('[data-title="node_ancestors"]').on('change', function(){
  var search_url = new URL('admin/members/options', location.origin);
  if (this.dataset['index']) {
    search_url.searchParams.set('index', this.dataset['index']);
  }
  if (this.value) {
    search_url.searchParams.set('department_id', this.value);
  }
  Rails.ajax({url: search_url, type: 'GET', dataType: 'script'});
});

$('#member_member_departments_attributes_0_organ_id').dropdown();
$('#member_member_departments_attributes_0_job_title_id').dropdown();
