require 'prawn'

def cellify(data, default_options = {:borders => []})
  output = []
  data.each do |row|
    output << []
    row.each do |cell|

      cellable =  case cell
                  when Prawn::Table::Cell, Prawn::Table
                    output.last << cell
                    next
                  when Hash
                    default_options.merge(cell)
                  else
                    default_options.merge(:content => cell.to_s)
                  end

      output.last << cellable
    end
  end

  output
end

Prawn::Document.generate('test.pdf') do |pdf|
  pdf.text 'all borders are on by default'
  data = [
    ['these', 'cells','will'],
    ['have', 'all', 'borders'],
    ['by','default','']
  ]
  pdf.table(data)
  pdf.move_down 20

  pdf.text 'respects values specified, but is way too verbose'
  data = [
    [{:content => 'these', :borders => [:bottom]}, {:content => 'cells', :borders => [:bottom]},{:content => 'will', :borders => [:bottom]}],
    [{:content => 'respect', :borders => []}, {:content => 'borders', :borders => []}, {:content => 'specified', :borders => []}],
  ]
  pdf.table(data)
  pdf.move_down 20

  pdf.text 'specifying default values for :cell_style ignores any values specified in the data definition'
  data = [
    [{:content => 'these', :borders => [:bottom]}, {:content => 'cells', :borders => [:bottom]},{:content => 'won\'t', :borders => [:bottom]}],
    [{:content => 'respect', :borders => []}, {:content => 'borders', :borders => []}, {:content => 'specified', :borders => []}],
  ]
  pdf.table(data, :cell_style => {:borders => []})
  pdf.move_down 20

  pdf.text 'use cellify method below to set default options up for each cell that can still be overridden as needed'
  data = [
    [{:content => 'these', :borders => [:bottom]}, {:content => 'cells', :borders => [:bottom]},{:content => 'will', :borders => [:bottom]}],
    ['respect', 'borders', 'specified'],
  ]
  pdf.table(cellify(data, :borders => []))

end

`open test.pdf`

