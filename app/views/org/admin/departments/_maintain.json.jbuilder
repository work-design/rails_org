json.extract! maintain,
              :id,
              :note,
              :state,
              :state_i18n,
              :created_at,
              :updated_at
json.pupil maintain.pupil, :id, :real_name, :nick_name, :birthday_type, :birthday, :gender, :avatar_url
json.tutelar maintain.tutelar, :id, :real_name, :mobile
json.tutelage maintain.tutelage, :relation
json.maintain_source maintain.maintain_source, :name
