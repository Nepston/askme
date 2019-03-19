module HashtagsHelper
  def add_hashtag_links(str, hashtag)
    result = str.gsub(Hashtag::REGEXP).each do |name|
      if name == hashtag
        link_to name, hashtag_url(name), class: 'select-tag-link'
      else
        link_to name, hashtag_url(name), class: 'question-tag-link'
      end
    end

    result.html_safe
  end
end
