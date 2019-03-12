$('#department_journal_ids').dropdown({
  apiSettings: {
    url: '/hr/journals/search?q={query}'
  },
  fields: {
    name: 'name',
    value: 'id'
  }
});
