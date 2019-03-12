require 'test_helper'

class AbsencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @absence = absences(:one)
  end

  test "should get index" do
    get absences_url
    assert_response :success
  end

  test "should get new" do
    get new_absence_url
    assert_response :success
  end

  test "should create absence" do
    assert_difference('Absence.count') do
      post absences_url, params: { absence: {  } }
    end

    assert_redirected_to absence_url(Absence.last)
  end

  test "should show absence" do
    get absence_url(@absence)
    assert_response :success
  end

  test "should get edit" do
    get edit_absence_url(@absence)
    assert_response :success
  end

  test "should update absence" do
    patch absence_url(@absence), params: { absence: {  } }
    assert_redirected_to absence_url(@absence)
  end

  test "should destroy absence" do
    assert_difference('Absence.count', -1) do
      delete absence_url(@absence)
    end

    assert_redirected_to absences_url
  end
end
