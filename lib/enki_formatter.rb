require 'redcarpet'

class EnkiFormatter
  class << self

    def format_comment_as_xhtml(text)
      output = Redcarpet.new(text, :fenced_code, :no_intraemphasis,
                                   :gh_blockcode, :xhtml, :filter_html,
                                   :autolink, :no_image, :safelink ).to_html
      coderay_filter(output)
    end

    def format_page_as_xhtml(text)
      output = Redcarpet.new(text, :hard_wrap , :fenced_code, :no_intraemphasis,
                                   :gh_blockcode, :xhtml ).to_html
      coderay_filter(output)
    end

  private

    def coderay_filter(text)
      text.gsub!(%r{<pre lang="(.*?)"><code>(.*?)</code></pre>}m) do |match|
        CodeRay.scan(CGI::unescapeHTML($2), $1).html(:line_numbers => :table).div
      end
      text
    end

  end
end
