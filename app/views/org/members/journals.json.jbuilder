json.array! @journals do |journal|
  json.me_name journal.me&.name
  json.me journal.me&.email
  json.journal journal.name_system
  json.journal_name_short journal.name_short
  json.journal_name_full journal.name_full
  json.office journal.office
  json.section journal.section
end
