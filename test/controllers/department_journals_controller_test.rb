require 'test_helper'

class DepartmentJournalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @department_journal = department_journals(:one)
  end

  test "should get index" do
    get department_journals_url
    assert_response :success
  end

  test "should get new" do
    get new_department_journal_url
    assert_response :success
  end

  test "should create department_journal" do
    assert_difference('DepartmentJournal.count') do
      post department_journals_url, params: { department_journal: {  } }
    end

    assert_redirected_to department_journal_url(DepartmentJournal.last)
  end

  test "should show department_journal" do
    get department_journal_url(@department_journal)
    assert_response :success
  end

  test "should get edit" do
    get edit_department_journal_url(@department_journal)
    assert_response :success
  end

  test "should update department_journal" do
    patch department_journal_url(@department_journal), params: { department_journal: {  } }
    assert_redirected_to department_journal_url(@department_journal)
  end

  test "should destroy department_journal" do
    assert_difference('DepartmentJournal.count', -1) do
      delete department_journal_url(@department_journal)
    end

    assert_redirected_to department_journals_url
  end
end
