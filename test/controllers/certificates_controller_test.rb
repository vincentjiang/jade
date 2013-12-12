require 'test_helper'

class CertificatesControllerTest < ActionController::TestCase
  setup do
    @certificate = certificates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:certificates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create certificate" do
    assert_difference('Certificate.count') do
      post :create, certificate: { chelsea_color_filter: @certificate.chelsea_color_filter, color1: @certificate.color1, color2: @certificate.color2, color3: @certificate.color3, comments: @certificate.comments, conclusion: @certificate.conclusion, cut: @certificate.cut, date_issue: @certificate.date_issue, date_test: @certificate.date_test, deep1: @certificate.deep1, deep2: @certificate.deep2, deep3: @certificate.deep3, dimension: @certificate.dimension, dimensions1: @certificate.dimensions1, dimensions2: @certificate.dimensions2, dimensions3: @certificate.dimensions3, distribution: @certificate.distribution, img_url: @certificate.img_url, infrared_spectrum: @certificate.infrared_spectrum, is_hoklas: @certificate.is_hoklas, is_measure: @certificate.is_measure, level: @certificate.level, magnification: @certificate.magnification, object: @certificate.object, polariscope: @certificate.polariscope, refractive_index: @certificate.refractive_index, report_no: @certificate.report_no, sg: @certificate.sg, shape: @certificate.shape, surface_feature: @certificate.surface_feature, transparency: @certificate.transparency, user_id: @certificate.user_id, uv_lw: @certificate.uv_lw, uv_sw: @certificate.uv_sw, visible_spectrum: @certificate.visible_spectrum, weight: @certificate.weight, weight_desc: @certificate.weight_desc, ww1: @certificate.ww1, ww2: @certificate.ww2, ww3: @certificate.ww3 }
    end

    assert_redirected_to certificate_path(assigns(:certificate))
  end

  test "should show certificate" do
    get :show, id: @certificate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @certificate
    assert_response :success
  end

  test "should update certificate" do
    patch :update, id: @certificate, certificate: { chelsea_color_filter: @certificate.chelsea_color_filter, color1: @certificate.color1, color2: @certificate.color2, color3: @certificate.color3, comments: @certificate.comments, conclusion: @certificate.conclusion, cut: @certificate.cut, date_issue: @certificate.date_issue, date_test: @certificate.date_test, deep1: @certificate.deep1, deep2: @certificate.deep2, deep3: @certificate.deep3, dimension: @certificate.dimension, dimensions1: @certificate.dimensions1, dimensions2: @certificate.dimensions2, dimensions3: @certificate.dimensions3, distribution: @certificate.distribution, img_url: @certificate.img_url, infrared_spectrum: @certificate.infrared_spectrum, is_hoklas: @certificate.is_hoklas, is_measure: @certificate.is_measure, level: @certificate.level, magnification: @certificate.magnification, object: @certificate.object, polariscope: @certificate.polariscope, refractive_index: @certificate.refractive_index, report_no: @certificate.report_no, sg: @certificate.sg, shape: @certificate.shape, surface_feature: @certificate.surface_feature, transparency: @certificate.transparency, user_id: @certificate.user_id, uv_lw: @certificate.uv_lw, uv_sw: @certificate.uv_sw, visible_spectrum: @certificate.visible_spectrum, weight: @certificate.weight, weight_desc: @certificate.weight_desc, ww1: @certificate.ww1, ww2: @certificate.ww2, ww3: @certificate.ww3 }
    assert_redirected_to certificate_path(assigns(:certificate))
  end

  test "should destroy certificate" do
    assert_difference('Certificate.count', -1) do
      delete :destroy, id: @certificate
    end

    assert_redirected_to certificates_path
  end
end
