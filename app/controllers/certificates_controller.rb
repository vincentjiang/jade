class CertificatesController < ApplicationController
  FONTS_PATH = "/SYSTEM/Library/Fonts/"

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

    Prawn::Document.generate(@pdf_file) do |pdf|
      pdf.font_families["msyh"] = {
        normal: {file: "#{FONTS_PATH}/msyh.ttf"},
        bold: {file: "#{FONTS_PATH}/msyhbd.ttf"}
      }
      pdf.font("msyh") do
        pdf.text "#{@certificate.report_no}", :align => :left
        pdf.text "#{@certificate.date_test}", :align => :center
        pdf.text "这是一个PDF测试文件123", :align => :right
      end

      pdf.image "public/#{@certificate.img_url}", width: 100, :position  => :right, :vposition => 200 if @certificate.img_url.present?

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
        format.html { redirect_to @certificate, notice: '证书创建成功' }
        format.json { render action: 'show', status: :created, location: @certificate }
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
        format.html { redirect_to @certificate, notice: '证书修改成功' }
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
      format.html { redirect_to certificates_url }
      format.json { head :no_content }
    end
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
