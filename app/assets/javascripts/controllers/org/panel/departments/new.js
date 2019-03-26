//= require rails_taxon/form
$('#department_type').dropdown();
$('#department_leader_id').dropdown({
  apiSettings: {
    url: '/members/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
