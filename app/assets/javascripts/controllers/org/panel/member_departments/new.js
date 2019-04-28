//= require rails_taxon/outer
$('[data-title="node_ancestors"]').on('change', function(){
  var search_path = '/nodes/outer';
  var search_url = new URL(window.location.origin + search_path);
  var value = this.value;
  if (value) {
    search_url.searchParams.set('node_id', value);
    search_url.searchParams.set('node_type', this.dataset['nodeType']);
    search_url.searchParams.set('entity_type', this.dataset['entityType']);
    search_url.searchParams.set('as', this.dataset['as']);
    search_url.searchParams.set('method', this.dataset['method']);
    if (this.dataset['index']) {
      search_url.searchParams.set('index', this.dataset['index']);
    }

    Rails.ajax({url: search_url, type: 'GET', dataType: 'script'});
  }
});
$('[data-title="job_title_id"]').dropdown();
$('[data-title="office_id"]').dropdown();
