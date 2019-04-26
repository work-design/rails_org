//= require rails_taxon/outer
//= require rails_taxon/form

$('#office_leader_id, #office_deputy_leader_id').dropdown({
  apiSettings: {
    url: '/my/member/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});

$('#office_timezone, #office_locale, #office_country').dropdown();
