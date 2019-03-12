//= require rails_taxon/form
$('#department_type').dropdown();
$('#department_leader_id').dropdown({
  apiSettings: {
    url: '/my/member/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
