module Jekyll
  class CollectionTag < Liquid::Tag
    def initialize(tag, prefix, tokens)
      @prefix = prefix.strip
      super
    end

    def collection(context)
      context.registers[:site].pages.select { |page|
        page.instance_variable_get('@dir') =~ /\A\/[0-9]+\z/ and
        page.name =~ /\Aindex\.(textile|md)\z/
      }.map { |page|
        {
          'seq'  => page.instance_variable_get('@dir').gsub(/[^0-9]+/, '').to_i,
          'date' => page.instance_variable_get('@data')['date']
        }
      }.sort_by { |page|
        page['seq']
      }
    end

    def render(context)
      "<ul>" +
        collection(context).map { |e|
        "<li><a href='#{@prefix}#{e['seq']}/'>\##{e['seq']} #{e['date']}</a></li>"
        }.join("\n") +
        "</ul>"
    end
  end
end

Liquid::Template.register_tag('collection', Jekyll::CollectionTag)
