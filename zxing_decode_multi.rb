require 'java'
require 'pp'

java_import com.google.zxing.MultiFormatReader
java_import com.google.zxing.BinaryBitmap
java_import com.google.zxing.Binarizer
java_import com.google.zxing.common.GlobalHistogramBinarizer
java_import com.google.zxing.LuminanceSource
java_import com.google.zxing.client.j2se.BufferedImageLuminanceSource
java_import com.google.zxing.multi.GenericMultipleBarcodeReader
java_import com.google.zxing.qrcode.QRCodeReader
java_import com.google.zxing.multi.qrcode.QRCodeMultiReader

java_import javax.imageio.ImageIO
java_import java.net.URL

def get_metadata(data)
  h = {}
  return h if data.nil?

  data.each do |key, value|
    h[key.get_name] = case value.class.to_s
                      when 'String'
                        value.to_s
                      when 'Java::JavaUtil::Vector'
                        value.map{|i| i.to_s}
                      else
                        puts ' missing: ' + value.class.to_s
                      end
  end

  h
end

def read_multiple(bitmap)
  #reader = QRCodeMultiReader.new
  reader = GenericMultipleBarcodeReader.new(MultiFormatReader.new)

  results = reader.decode_multiple(bitmap)

  results.each do |result|
    p ' ---- New Result ---- '
    p result.get_text, ' ---- '
  end

end

def read_single(bitmap)
  p QRCodeReader.new.decode(bitmap).get_text
end

file      = Java::JavaIO::File.new('/Users/rjackson/Desktop/record_request-1.png')
image     = ImageIO.read(file)
luminance = BufferedImageLuminanceSource.new(image)
binarizer = GlobalHistogramBinarizer.new(luminance)
bitmap    = BinaryBitmap.new(binarizer)

read_multiple(bitmap)