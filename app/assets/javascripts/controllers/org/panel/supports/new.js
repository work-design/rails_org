//= require rails_taxon/outer

$('#support_kind').dropdown();
$('#support_office_id').dropdown({
  placeholder: false
});

$('#support_member_id').dropdown({
  apiSettings: {
    url: '/my/member/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});

$('#support_supporter_id').dropdown({
  apiSettings: {
    url: '/my/member/search?q={query}',
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
