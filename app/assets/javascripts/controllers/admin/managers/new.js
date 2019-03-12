$('#manager_leader_id').dropdown({
  apiSettings: {
    url: '/admin/managers/search?q={query}'
  },
  fields: {
    name: 'real_name',
    value: 'id'
  },
  minCharacters: 2
});
$('#manager_type').dropdown();