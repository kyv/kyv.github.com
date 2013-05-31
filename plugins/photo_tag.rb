# Title: Gallery Tag for Jekyll
# Authors: Kevin Brown
# Description: gallery using extended bootstrap carousel. Uses a CDN if needed.
#
# Adaption of "Photos tag for Jekyll" by Devin Weaver
# Using bootstrap carosel-extended instead of fancybox: "http://bootsnipp.com/snipps/carousel-extended"
# We have also left out the photo tag and are using solly the gallery function
#
# ** This only covers the markup. Not the integration of carousel-extended **
#
# To see an unabridged explination on integrating this with [FancyBox][1]
# Please read my [blog post about it][2].
#
# [1]: http://fancyapps.com/fancybox/
# [2]: http://tritarget.org/blog/2012/05/07/integrating-photos-into-octopress-using-fancybox-and-plugin/
#
# Syntax {% photo filename [tumbnail] [title] %}
# Syntax {% photos filename [filename] [filename] [...] %}
# If the filename has no path in it (no slashes)
# then it will prefix the `_config.yml` setting `photos_prefix` to the path.
# This allows using a CDN if desired.
#
# To make FancyBox work well with OctoPress You need to include the style fix.
# In your `source/_include/custom/head.html` add the following:
#
#     {% carouselstylefix %}
#
# Examples:
# {% photo photo1.jpg My Photo %}
# {% photo /path/to/photo.jpg %}
# {% gallery %}
# photo1.jpg: my title 1
# photo2.jpg[thumnail.jpg]: my title 2
# photo3.jpg: my title 3
# {% endgallery %}
#
# Output:
# <a href="photo1.jpg" class="fancybox" title="My Photo"><img src="photo1_m.jpg" alt="My Photo" /></a>
# <a href="/path/to/photo.jpg" class="fancybox" title="My Photo"><img src="/path/to/photo_m.jpg" alt="My Photo" /></a>
# <ul class="gallery">
#   <li><a href="photo1.jpg" class="fancybox" rel="gallery-e566c90e554eb6c157de1d5869547f7a" title="my title 1"><img src="photo1_m.jpg" alt="my title 1" /></a></li>
#   <li><a href="photo2.jpg" class="fancybox" rel="gallery-e566c90e554eb6c157de1d5869547f7a" title="my title 2"><img src="photo2_m.jpg" alt="my title 2" /></a></li>
#   <li><a href="photo3.jpg" class="fancybox" rel="gallery-e566c90e554eb6c157de1d5869547f7a" title="my title 3"><img src="photo3_m.jpg" alt="my title 3" /></a></li>
# </ul>

require 'digest/md5'

module Jekyll

  class PhotosUtil
    def initialize(context)
      @context = context
    end

    def path_for(filename)
      filename = filename.strip
      prefix = (@context.environments.first['site']['photos_prefix'] unless filename =~ /^(?:\/|http)/i) || ""
      "#{prefix}#{filename}"
    end

    def thumb_for(filename, thumb=nil)
      filename = filename.strip
      # FIXME: This seems excessive
      if filename =~ /\./
        thumb = (thumb unless thumb == 'default') || filename.gsub(/(?:_b)?\.(?<ext>[^\.]+)?$/, "_m.\\k<ext>")
      else
        thumb = (thumb unless thumb == 'default') || "#{filename}_m"
      end
      path_for(thumb)
    end
  end

  class CarouselStylePatch < Liquid::Tag
    def render(context)
      return <<-eof
<!-- Fix Carousel style for OctoPress -->

<style type="text/css">
.entry-content .slider_area .row
{
  margin-left: 0px;
}
</style>
      eof
    end
  end

  class PhotoTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      if /(?<filename>\S+)(?:\s+(?<thumb>\S+))?(?:\s+(?<title>.+))?/i =~ markup
        @filename = filename
        @thumb = thumb
        @title = title
      end
      super
    end

    def render(context)
      p = PhotosUtil.new(context)
      if @filename
        "<a href=\"#{p.path_for(@filename)}\" class=\"fancybox\" title=\"#{@title}\"><img src=\"#{p.thumb_for(@filename,@thumb)}\" alt=\"#{@title}\" /></a>"
      else
        "Error processing input, expected syntax: {% photo filename [thumbnail] [title] %}"
      end
    end
  end

  class GalleryTag < Liquid::Block
    def initialize(tag_name, markup, tokens)
      # No initializing needed
      super
    end

    def render(context)
      # Convert the entire content array into one large string
      lines = super
      # Get a unique identifier based on content
      md5 = Digest::MD5.hexdigest(lines)
      # use first 8 characters of md5 for id
      id = md5[0,8]
      # split the text by newlines
      lines = lines.split("\n")

      p = PhotosUtil.new(context)
      carousel = "<div class=\"slider_area\"><div class=\"row\"><div class=\"span12\" id=\"slider_#{id}\"><div id=\"carousel_#{id}\" class=\"carousel slide\"><div class=\"carousel-inner\">"
      thumbs = "<div class=\"row hidden-phone span12\" id=\"slider-thumbs\"><ul class=\"gallery thumbnails\">\n"

      lines.each_with_index do |line, i|
        if /(?<filename>[^\[\]:]+)(?:\[(?<thumb>\S*)\])?(?::(?<title>.*))?/ =~ line
          thumbs << "<li class=\"span2\"><a class=\"thumbnail\" id=\"carousel-selector-#{id}-#{i}\"rel=\"gallery-#{md5}\" title=\"#{title.nil? || title.strip}\">"
          thumbs << "<img src=\"#{p.path_for(filename)}\" alt=\"#{title.nil? || title.strip}\" /></a></li>"
          carousel << "<div class=\"item#{ (i == 1 ? " active" : "") }\" data-slide-number=\"#{i}\"><img src=\"#{p.path_for(filename)}\" /></div>"

        end
      end
      thumbs << "\n</ul></div>"
      carousel << "\n</div>"
      carousel << "<a class=\"carousel-control left\" href=\"#carousel_#{id}\" data-slide=\"prev\"><i class=\"icon-caret-left\"></i></a><a class=\"carousel-control right\" href=\"#carousel_#{id}\" data-slide=\"next\"><i class=\"icon-caret-right\"></i></a>"
      carousel << "</div></div>"
      carousel << thumbs
      carousel << "</div></div>"
      carousel
    end
  end

end

Liquid::Template.register_tag('photo', Jekyll::PhotoTag)
Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)
Liquid::Template.register_tag('carouselstylefix', Jekyll::CarouselStylePatch)
