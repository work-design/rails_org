require 'prawn/measurement_extensions'
class CertificationPdf
	include Prawn::View
	include PdfTextHelper
	include PdfTableHelper

	attr_reader :document

	def initialize(editor_badge_id = nil)
		default_config = {
			page_size: [297.mm, 210.mm]
		}
		@document = Prawn::Document.new(default_config)

    @document.font_families['Damion'] = {
			normal: { file: "#{Rails.root}/app/pdfs/fonts/Damion-Regular.ttf" }
		}
		@document.font_families['SansPro'] = {
			normal: { file: "#{Rails.root}/app/pdfs/fonts/SourceSansPro-Regular.ttf" }
		}
    @document.font('SansPro')
		@editor_badge = MemberBadge.find editor_badge_id
		@badge = @editor_badge.badge
		@member = @editor_badge.member
		write_content
	end

  def render
		@document.render
	end

	def write_content
    image "#{Rails.root}/app/pdfs/images/cert_01.jpg", at: [-36, 210.mm - 36], width: 297.mm, height: 210.mm
    bounding_box([20.mm, 210.mm - 80.mm], width: bounds.width - 40.mm) do
      text 'THIS IS TO CERTIFY THAT', align: :center, size: 18
			font 'Damion'
			text "#{@member.name}", align: :center, color: 'C30D23', size: 55
			move_down 10
			font 'SansPro'
			text 'HAS ACHIEVED THE LEVEL OF RECOGNITION AS A PROFESSIONAL CERTIFIED', align: :center, size: 18
			move_down 8
			text @badge.title.to_s.upcase, align: :center, size: 23
			move_down 8
			text 'THROUGH MASTERY OF  THE KNOWLEDGE AND SKILLS IN THE EDITORIAL OCCUPATIONAL STANDARDS ESTABLISHED BY MDPI.', align: :center, size: 16
			move_down 8
			text "GIVEN AT #{@member.office&.name} #{@editor_badge.awarded_on}", align: :center, size: 18
			#transparent(0.5) { stroke_bounds }
    end
    write_back
  end

  def write_back
    start_new_page
    image "#{Rails.root}/app/pdfs/images/cert_2.jpg", at: [-36, 210.mm - 36]
  end

end
