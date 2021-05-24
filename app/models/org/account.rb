module Org
  class Account < ApplicationRecord
    include Model::Account

    self.table_name = 'auth_accounts'

  end
end
