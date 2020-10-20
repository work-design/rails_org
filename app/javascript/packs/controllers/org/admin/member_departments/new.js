$('[data-title="node_ancestors"]').on('change', function(){
  var search_url = new URL(this.form.action + '/options');
  if (this.value) {
    search_url.searchParams.set('department_id', this.value);
    Rails.ajax({url: search_url, type: 'GET', dataType: 'script'});
  }
});
$('#member_department_organ_id').dropdown({
  placeholder: false
});
$('#member_department_job_title_id').dropdown({
  placeholder: false
});
