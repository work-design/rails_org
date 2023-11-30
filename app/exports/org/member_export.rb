module Org
  class MemberExport
    extend RailsData::Export

    config do
      collect -> (params){
        if params['created_at-lte']
          params['created_at-lte'] = params['created_at-lte'].to_time.end_of_day
        end
        Member.default_where(params)
      }
      column header: '姓名', field: ->(o) { o.name }
      column header: '日期', field: ->(o) { o.created_at.to_s(:date) }
      column header: '月度', field: ->(o) { o.created_at.to_s(:month) }, x_axis: true
    end
  end
end
