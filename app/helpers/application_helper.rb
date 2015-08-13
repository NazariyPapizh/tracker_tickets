module ApplicationHelper
  def embedded_svg filename, options={}
    embedded_svg_from_abs(Rails.root.join('app', 'assets', 'images', 'svg', filename), options)
  end

  def embedded_svg_from_abs filename, options = {}
    file = File.read(filename)
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def embedded_svg_from_root_directory filename, options = {}
    embedded_svg_from_abs(Rails.root.join( filename), options)
  end

  def self.embedded_svg_js filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', 'svg', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def rand_ref
    a = ('A'..'Z').to_a
    h = ('A'..'F').to_a + (0..9).to_a
    af = -> () { (1..3).inject(''){ |sum, i| sum += a.sample } }
    hf = -> () { (1..2).inject(''){ |sum, i| sum += h.sample.to_s } }
    str = [af.call, hf.call, af.call, hf.call, af.call].join('-')
  end
end
