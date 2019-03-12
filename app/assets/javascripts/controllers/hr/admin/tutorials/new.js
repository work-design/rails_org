$('#tutorial_member_id').dropdown({
  apiSettings: {
    url: '/hr/members/leaders?q={query}'
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
$('#tutorial_tutor_id').dropdown({
  apiSettings: {
    url: '/hr/members/leaders?q={query}'
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});

$('#tutorial_kind').dropdown();
