# frozen_string_literal: true

require 'test_helper'

class ConStaffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @con_staff = con_staffs(:one)
  end

  test 'should get index' do
    get con_staffs_url
    assert_response :success
  end

  test 'should get new' do
    get new_con_staff_url
    assert_response :success
  end

  test 'should create con_staff' do
    assert_difference('ConStaff.count') do
      post con_staffs_url, params: { con_staff: { email: @con_staff.email, event_id: @con_staff.event_id, name: @con_staff.name, phone: @con_staff.phone, title: @con_staff.title } }
    end

    assert_redirected_to con_staff_url(ConStaff.last)
  end

  test 'should show con_staff' do
    get con_staff_url(@con_staff)
    assert_response :success
  end

  test 'should get edit' do
    get edit_con_staff_url(@con_staff)
    assert_response :success
  end

  test 'should update con_staff' do
    patch con_staff_url(@con_staff), params: { con_staff: { email: @con_staff.email, event_id: @con_staff.event_id, name: @con_staff.name, phone: @con_staff.phone, title: @con_staff.title } }
    assert_redirected_to con_staff_url(@con_staff)
  end

  test 'should destroy con_staff' do
    assert_difference('ConStaff.count', -1) do
      delete con_staff_url(@con_staff)
    end

    assert_redirected_to con_staffs_url
  end
end
