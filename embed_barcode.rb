require 'prawn'
require 'barby'
require 'barby/outputter/prawn_outputter'

Prawn::Document.generate('embed_barcode.pdf', :margin => 0) do |pdf|
  image 'background_image_sample_page.png', :width => bounds.width, :height => bounds.height

  barcode1 = Barby::QrCode.new('test123')
  barcode2 = Barby::QrCode.new('test456')

  barcode1.annotate_pdf(pdf, :x => pdf.bounds.right - 50, :y => pdf.bounds.top - 50, :xdim => 2)
  barcode2.annotate_pdf(pdf, :x => pdf.bounds.left + 8, :y => pdf.bounds.bottom + 50, :xdim => 2)
end

`open embed_barcode.pdf`