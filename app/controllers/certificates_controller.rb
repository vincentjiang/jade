class CertificatesController < ApplicationController
  FONTS_PATH = "public/assets/fonts/"

  before_action :set_certificate, only: [:show, :edit, :update, :destroy]

  # GET /certificates
  # GET /certificates.json
  def index
    @certificates = Certificate.all
  end

  # GET /certificates/1
  # GET /certificates/1.json
  def show
    # if no pdf folder, here will auto create the pdf folder
    unless Dir.exist?("pdf")
      Dir.mkdir("pdf")
    end

    @file_name = "#{User.find_by_id(session[:user_id]).ename}.pdf"
    @pdf_file = "pdf/" + @file_name

    # require "prawn/measurement_extensions"

    Prawn::Document.generate(
      @pdf_file,
      left_margin: 40,
      :page_size => 'A4') do |pdf|

      pdf.font_families["msyh"] = {
        normal: {file: "#{FONTS_PATH}/msyh.ttf"},
        bold: {file: "#{FONTS_PATH}/msyhbd.ttf"}
      }

      pdf.font("msyh", size: 7) do

        # pdf.stroke_axis :step_length => 20

        pdf.bounding_box([10, 770], :width => 200, :height => 90, :padding => 20) do
          pdf.image "#{Rails.root}/app/assets/images/pdf_header.jpg", :width => 200, :height => 90
        end

        pdf.move_cursor_to 670

        pdf.text "翡翠鉴定报告  Fei Cui Testing Report",size: 16,:style => :bold

        pdf.move_cursor_to 650

        data1 = [
          ["报告号码 Report No.", ":", {:content => "#{@certificate.report_no}", :colspan => 5, :align => :center}],
          ["测试日期 Test Date", ":", "#{@certificate.date_test}", "","签发日期 Issue Date", ":", "#{@certificate.date_issue}"]]

        pdf.table(data1, :position => :right) do
          cells.border_width = 0
          row(0).columns(2).borders = [:bottom]
          row(0).columns(2).border_width = 1
          row(1).columns([2,6]).borders = [:bottom]
          row(1).columns([2,6]).border_width = 1
        end

        pdf.move_cursor_to 630

        pdf.text "鉴定结果  Test Result",size: 14

        pdf.move_cursor_to 600

        @weight = @certificate.weight < 200 ? @certificate.weight.round(2) : @certificate.weight
        @dimension =  (@certificate.dimensions1 && @certificate.dimensions2 && @certificate.dimensions3) ? "约/Appro. #{@certificate.dimensions1}x #{@certificate.dimensions2}x #{@certificate.dimensions3}" : "约/Appro. #{@certificate.dimensions1}x #{@certificate.dimensions2}" 

        data2 = [
          ["形状和琢型", "Shape and Cut", ":", "#{@certificate.shape}#{@certificate.object} - #{@certificate.cut}"],
          ["", "", "", "Bunddha Pendant"],
          ["尺寸（毫米）", "Dimensions(mm)", ":", "#{@dimension}"],
          ["重量（克拉）", "Weight(ct)", ":", "#{@weight} （#{@certificate.weight_desc} With Mounting）"],
          ["透明度", "Transparency", ":", "#{@certificate.transparency} Transparency"],
          ["颜色", "Color", ":", "#{@certificate.color1}"],
          ["", "", "", "Pale Green"],
          ["偏光仪", "Polariscope", ":", "#{@certificate.polariscope} Polycrystalline"],
          ["折射率", "Refractive Index", ":", "#{@certificate.refractive_index}"],
          ["比重", "Specific Gravity", ":", "#{@certificate.is_measure} Not Measurable"],
          ["荧光", "Fluorescence", "", ""],
          ["紫外线长波", "UV-LW", ":", "#{@certificate.uv_lw} Faint"],
          ["紫外线短波", "UV-SW", ":", "#{@certificate.uv_sw} Faint"],
          ["滤色镜", "Chelsea Color Filter", ":", "#{@certificate.chelsea_color_filter} Green"],
          ["可见光谱", "Visible Spectrum", ":", "#{@certificate.visible_spectrum}"],
          ["", "", "", "Fei Cui Spectrum"],
          ["放大观察", "Magnification", ":", "#{@certificate.magnification} - #{@certificate.surface_feature}"],
          ["", "", "", "Fine Granular & Fibrous Texture"]]

        pdf.table(data2) do
          cells.border_width = 0
          row(0..9).columns(3).borders = [:bottom]
          row(0..9).columns(3).border_width = 1
          row(11..18).columns(3).borders = [:bottom]
          row(11..18).columns(3).border_width = 1
        end

        pdf.move_cursor_to 600

        data3 = [
          ["应用仪器", "Instruments Used"],
          ["滤色镜", "Chelsea Color Filter"],
          ["电子磅", "Electonic Balance"],
          ["电子表尺", "Electronic Gauge"],
          ["电子卡尺", "Electronic Caliper"],
          ["红外线光谱仪", "FTIR Spectrometer"],
          ["宝石学显微镜", "Gemmological Microscope"],
          ["偏光仪", "Polariscope"],
          ["折射仪", "Refractometer"],
          ["分光仪", "Spectroscope"],
          ["荧光灯", "Ultra-violet Lamp"],
          [{:content => "彩色照片只显示测试石的形状\nColor photo shows the shape of test stone only", :colspan => 2}],
          [{:content => "箭咀所示为测试物\nOnly arrow pointed stone is being tested", :colspan => 2}]]

        pdf.table(data3, :position => :right, :width => 200) do
          cells.border_width = 0
          cells.padding = 0
          row(0).padding_bottom = 5
          row(1..10).padding_left = 2
          row(11..12).padding_top = 5
          row(1..10).size = 6
          row(0..3).columns(2).borders = [:bottom]
          row(0..3).columns(2).border_width = 1
        end

        pdf.move_cursor_to 270

        pdf.image "public/#{@certificate.img_url}", :height => 160 if @certificate.img_url.present?

        pdf.move_cursor_to 210

        data4 = [
          ["结论", ":", "#{@certificate.conclusion} - #{@certificate.level}玉"],
          ["Conclusion", ":", "Natural Fei Cui - Type A"],
          ["评论", ":", "#{@certificate.comments}"],
          ["Comments", ":", "Natural Color Fei Cui without resin"]]

        pdf.table(data4, :position => :right) do
          cells.border_width = 0
          row(0..3).columns(2).borders = [:bottom]
          row(0..3).columns(2).border_width = 1
        end

        pdf.move_cursor_to 90

        data5 = [
          ["红外线光谱", "Infrared Spectrum", ":", "#{@certificate.infrared_spectrum}"],
          ["", "", ":", "No resin is detected"]]

        pdf.table(data5) do
          cells.border_width = 0
          row(0..1).columns(3).borders = [:bottom]
          row(0..1).columns(3).border_width = 1
        end

        pdf.move_cursor_to 70

        data6 = [
          ["", ""],
          ["#{@certificate.user.cname}", "#{@certificate.user.ename}"],
          ["#{@certificate.user.ctitle}", "#{@certificate.user.etitle}"]]

        pdf.table(data6, :position => :right, :width => 180) do
          cells.border_width = 0
          row(0).borders = [:bottom]
          row(0).border_width = 1
        end

        pdf.move_cursor_to 20

        pdf.text "END OF REPORT (P1 OF 1)", :align => :center

      end

    end
    send_file(@pdf_file,
              filename: "#{@certificate.report_no}.pdf",
              type: "application/pdf",
              disposition: "inline")
  end

  # GET /certificates/new
  def new
    @certificate = Certificate.new
  end
  # GET /certificates/1/edit
  def edit
  end

  # POST /certificates
  # POST /certificates.json
  def create
    @certificate = Certificate.new(certificate_params)

    respond_to do |format|
      if @certificate.save
        format.html { redirect_to certificates_path, notice: '证书创建成功' }
        format.json { render action: 'index', status: :created, location: @certificate }
      else
        format.html { render action: 'new' }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certificates/1
  # PATCH/PUT /certificates/1.json
  def update
    respond_to do |format|
      if @certificate.update(certificate_params)
        format.html { redirect_to certificates_path, notice: '证书修改成功' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certificates/1
  # DELETE /certificates/1.json
  def destroy
    @certificate.destroy
    respond_to do |format|
      format.html { redirect_to certificates_url, notice: "删除 #{@certificate.report_no} 证书成功" }
      format.json { head :no_content }
    end
    Dir.rmdir("public/uploads/certificate/img_url/#{@certificate.id}") if Dir.exist?("public/uploads/certificate/img_url/#{@certificate.id}")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certificate
      @certificate = Certificate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def certificate_params
      params.require(:certificate).permit(:report_no, :is_hoklas, :date_test, :date_issue, :shape, :object, :cut, :dimensions1, :dimensions2, :dimensions3, :dimension, :weight, :weight_desc, :transparency, :deep1, :color1, :deep2, :color2, :deep3, :color3, :distribution, :polariscope, :refractive_index, :is_measure, :ww1, :ww2, :ww3, :sg, :uv_lw, :uv_sw, :chelsea_color_filter, :visible_spectrum, :magnification, :surface_feature, :infrared_spectrum, :level, :conclusion, :comments, :img_url, :user_id)
    end
end
