class SuperJobTitle < JobTitle
  include RailsOrg::JobTitle::SuperJobTitle
end unless defined? SuperJobTitle
