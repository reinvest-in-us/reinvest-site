module LinkPrefixHelper
    def prefix(link)
        (link.starts_with? 'http') ? link : "http://#{link}"
    end
end
