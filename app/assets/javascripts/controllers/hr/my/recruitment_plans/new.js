$('#recruitment_plan_journal_id').dropdown({
    apiSettings: {
        url: '/editing/journals/search?q={query}'
    },
    fields: {
        name: 'name',
        value: 'id'
    }
});
