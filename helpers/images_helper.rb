require 'lib/svg'
require 'digest/md5'

module ImagesHelper
  def page_image_path(filename)
    path = current_page.eponymous_directory_path

    # remove index from path
    path.gsub!(/index\/\z/, '') if current_page.directory_index?

    # set to home if only slash
    path = 'home/' if path.blank?

    image_path("#{path}#{filename}")
  end

  def svg_tag(filename, options={})
    root      = Middleman::Application.root
    file_path = File.join(root, 'source', config[:images_dir], filename)
    return '(SVG img not found)' unless File.exists?(file_path)

    SVG.inline(file_path, options)
  end

  def gravatar_for(email)
    hash = Digest::MD5.hexdigest(email.chomp.downcase)
    "http://www.gravatar.com/avatar/#{hash}?s=180"
  end
end
