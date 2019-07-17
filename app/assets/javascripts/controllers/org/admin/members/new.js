//= require rails_taxon/outer
$('[data-title="node_ancestors"]').on('change', function(){
  var search_url = new URL('admin/members/options', location.origin);
  if (this.dataset['as']) {
    search_url.searchParams.set('as', this.dataset['as']);
  }
  if (this.value) {
    search_url.searchParams.set('department_id', this.value);
  }
  Rails.ajax({url: search_url, type: 'GET', dataType: 'script'});
});

$('[data-title="job_title_id"]').dropdown();
