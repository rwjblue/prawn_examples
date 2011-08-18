require 'prawn'

Prawn::Document.generate('background_image.pdf') do
  image 'background_image_sample_page.png', :width => bounds.width, :height => bounds.height
  puts bounds.top
  draw_text 'contracted', :at => [250,487]
  (1..10).each do |height|
    draw_text 'test_text_' + height.to_s, :at => [ 0, height * 72]
  end
end

`open background_image.pdf`