class DepartmentJobTitle < JobTitle
  include RailsOrg::JobTitle::DepartmentJobTitle
end unless defined? DepartmentJobTitle
