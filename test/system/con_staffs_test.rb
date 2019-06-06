require "application_system_test_case"

class ConStaffsTest < ApplicationSystemTestCase
  setup do
    @con_staff = con_staffs(:one)
  end

  test "visiting the index" do
    visit con_staffs_url
    assert_selector "h1", text: "Con Staffs"
  end

  test "creating a Con staff" do
    visit con_staffs_url
    click_on "New Con Staff"

    fill_in "Email", with: @con_staff.email
    fill_in "Event", with: @con_staff.event_id
    fill_in "Name", with: @con_staff.name
    fill_in "Phone", with: @con_staff.phone
    fill_in "Title", with: @con_staff.title
    click_on "Create Con staff"

    assert_text "Con staff was successfully created"
    click_on "Back"
  end

  test "updating a Con staff" do
    visit con_staffs_url
    click_on "Edit", match: :first

    fill_in "Email", with: @con_staff.email
    fill_in "Event", with: @con_staff.event_id
    fill_in "Name", with: @con_staff.name
    fill_in "Phone", with: @con_staff.phone
    fill_in "Title", with: @con_staff.title
    click_on "Update Con staff"

    assert_text "Con staff was successfully updated"
    click_on "Back"
  end

  test "destroying a Con staff" do
    visit con_staffs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Con staff was successfully destroyed"
  end
end
