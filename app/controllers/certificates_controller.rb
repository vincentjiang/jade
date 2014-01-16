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

    require "prawn/measurement_extensions"

    Prawn::Document.generate(
      @pdf_file,
      left_margin: 20.mm,
      right_margin: 15.mm,
      top_margin: 18.mm,
      bottom_margin: 15.mm,
      :page_size => 'A4') do |pdf|

      pdf.font_families["msyh"] = {
        normal: {file: "#{FONTS_PATH}/msyh.ttf"},
        bold: {file: "#{FONTS_PATH}/msyhbd.ttf"}
      }

      pdf.font("msyh", :size => 10) do
        pdf.bounding_box([0, 270.mm], :width => 85.mm, :height => 40.mm) do
         pdf.image "app/assets/images/pdf_header.jpg", width: 250 if @certificate.img_url.present?
        end

        pdf.bounding_box([0, 230.mm], :width => 180.mm, :height => 10.mm) do
          # pdf.stroke_bounds
          pdf.text "翡翠鉴定报告        Fei Cui Testing Report"
        end

        pdf.bounding_box([10, 220.mm], :width => 85.mm, :height => 10.mm) do
          pdf.text "鉴定结果        Test Result"
        end

        pdf.bounding_box([10, 210.mm], :width => 110.mm, :height => 125.mm) do
          pdf.text "这里"
        end

        pdf.bounding_box([120.mm, 210.mm], :width => 60.mm, :height => 125.mm) do
          pdf.stroke_bounds
          pdf.text "这里"
        end

        pdf.bounding_box([10.mm, 80.mm], :width => 80.mm, :height => 60.mm) do
          pdf.stroke_bounds
          pdf.text "这里"
        end

        pdf.bounding_box([100.mm, 60.mm], :width => 80.mm, :height => 40.mm) do
          pdf.stroke_bounds
          pdf.text "这里"
        end

        pdf.bounding_box([10.mm, 15.mm], :width => 80.mm, :height => 10.mm) do
          pdf.stroke_bounds
          pdf.text "红外线光谱"
        end

        pdf.bounding_box([100.mm, 15.mm], :width => 80.mm, :height => 10.mm) do
          pdf.stroke_bounds
          pdf.text "这里"
        end

        pdf.bounding_box([80.mm, 10.mm], :width => 30.mm, :height => 10.mm) do
          pdf.stroke_bounds
          pdf.text "这里"
        end


        # pdf.image "app/assets/images/pdf_header.jpg", width: 250, :at => [100, 100] if @certificate.img_url.present?

        # pdf.move_down 4.mm

        # pdf.font("msyh", :size => 14, :style => :bold) do
        #   pdf.text "翡翠鉴定报告        Fei Cui Testing Report"
        # end

        # pdf.move_down 8.mm

        # pdf.text "鉴定结果   Testing Result", :size => 12

        # pdf.move_down 4.mm

        # data = [["形状及琢型", "Shape and Cut", "佛公吊坠"],
        #   ["", "", "Buddha Pendant"],
        #   ["形状及琢型", "Shape and Cut", "佛公吊坠"],
        #   ["", "", "Buddha Pendant"],
        #   ["形状及琢型", "Shape and Cut", "佛公吊坠"],
        #   ["", "", "Buddha Pendant"]]

        # pdf.table data do |t|
        #   t.cells.border_width = 0
        #   t.cells.style :padding_left => 0, :padding_bottom => 0
        # end

        # pdf.start_new_page

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
