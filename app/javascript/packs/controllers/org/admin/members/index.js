import { Controller } from 'stimulus'

class MemberController extends Controller {

  connect() {
    console.log('Member Controller works!')
  }

  request(element) {
    let ele = element.target
    let search_url = new URL('admin/members/options', location.origin)
    if (ele.value) {
      search_url.searchParams.set('department_id', ele.value)
    }
    search_url.searchParams.set('as', ele.dataset['as'])
    search_url.searchParams.set('method', ele.dataset['method'])
    search_url.searchParams.set('outer', ele.dataset['outer'])
    if (ele.dataset['index']) {
      search_url.searchParams.set('index', ele.dataset['index'])
    }

    Rails.ajax({url: search_url, type: 'GET', dataType: 'script'})
  }

}

application.register('member', MemberController)
