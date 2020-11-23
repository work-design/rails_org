require "application_system_test_case"

class OrganDomainsTest < ApplicationSystemTestCase
  setup do
    @org_admin_organ_domain = org_admin_organ_domains(:one)
  end

  test "visiting the index" do
    visit org_admin_organ_domains_url
    assert_selector "h1", text: "Organ Domains"
  end

  test "creating a Organ domain" do
    visit org_admin_organ_domains_url
    click_on "New Organ Domain"

    fill_in "Appid", with: @org_admin_organ_domain.appid
    fill_in "Domain", with: @org_admin_organ_domain.domain
    fill_in "Host", with: @org_admin_organ_domain.host
    fill_in "Port", with: @org_admin_organ_domain.port
    fill_in "Subdomain", with: @org_admin_organ_domain.subdomain
    click_on "Create Organ domain"

    assert_text "Organ domain was successfully created"
    click_on "Back"
  end

  test "updating a Organ domain" do
    visit org_admin_organ_domains_url
    click_on "Edit", match: :first

    fill_in "Appid", with: @org_admin_organ_domain.appid
    fill_in "Domain", with: @org_admin_organ_domain.domain
    fill_in "Host", with: @org_admin_organ_domain.host
    fill_in "Port", with: @org_admin_organ_domain.port
    fill_in "Subdomain", with: @org_admin_organ_domain.subdomain
    click_on "Update Organ domain"

    assert_text "Organ domain was successfully updated"
    click_on "Back"
  end

  test "destroying a Organ domain" do
    visit org_admin_organ_domains_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Organ domain was successfully destroyed"
  end
end
